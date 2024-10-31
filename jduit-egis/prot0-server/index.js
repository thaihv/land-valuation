import express from "express";
import bodyParser from "body-parser";
import mongoose from "mongoose";
import cors from "cors";
import dotenv from "dotenv";
import helmet from "helmet";
import morgan from "morgan";
import multer from "multer";
import path from "path";
import { fileURLToPath } from "url";
import clientRoutes from "./routes/client.js";
import generalRoutes from "./routes/general.js";
import managementRoutes from "./routes/management.js";
import salesRoutes from "./routes/sales.js";
import { Eureka } from 'eureka-js-client';
import session from 'express-session';
import { keycloak, memoryStore } from './keycloak-config.js';

// data imports
import User from "./models/User.js";
import Product from "./models/Product.js";
import ProductStat from "./models/ProductStat.js";
import Transaction from "./models/Transaction.js";
import OverallStat from "./models/OverallStat.js";
import AffiliateStat from "./models/AffiliateStat.js";
import {
  dataUser,
  dataProduct,
  dataProductStat,
  dataTransaction,
  dataOverallStat,
  dataAffiliateStat,
} from "./data/index.js";

/* CONFIGURATIONS */
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config();
const app = express();
app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
    store: memoryStore,
  })
);
app.use(keycloak.middleware());
const allowedOrigins = ["http://localhost:3000", "http://localhost:5173"];
app.use(cors({
  origin: function (origin, callback) {
    if (!origin || allowedOrigins.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      callback(new Error("Not allowed by CORS"));
    }
  },
  credentials: true,
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"], // Add other methods as needed
  allowedHeaders: ["Authorization", "Content-Type"]
}));
const contextPath = process.env.CONTEXT_PATH || '/prot0-api';
app.use(express.json());
app.use(helmet());
app.use(helmet.crossOriginResourcePolicy({ policy: "cross-origin" }));
app.use(morgan("common"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use("/assets", express.static(path.join(__dirname, "public/assets")));
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

const storage_uploads = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./uploads");
  },
  filename: function (req, file, cb) {
    cb(null,  file.originalname);
  },
});

const data_upload = multer({ storage: storage_uploads });
// For upload any data into uploads folder
app.post(`${contextPath}/uploads`, keycloak.protect(), data_upload.single('file'), (req, res) => {
  console.log('body', req.file);
  // here you can do anything that you want for the file such as you want to save it to database here
  res.json({ success: true })
})

/* ROUTES */
app.use(`${contextPath}/client`, clientRoutes);
app.use(`${contextPath}/general`, generalRoutes);
app.use(`${contextPath}/management`, managementRoutes);
app.use(`${contextPath}/sales`, salesRoutes);
/* MONGOOSE SETUP */
const PORT = process.env.PORT || 9000;

// Configure Eureka client
const client = new Eureka({
  instance: {
    app: 'prot0-service',               // Unique service name
    instanceId: `prot0-service:${PORT}`, // Unique instance ID (service name + port)
    hostName: 'localhost',
    ipAddr: '127.0.0.1',
    statusPageUrl: `http://localhost:${PORT}/info`,
    port: {
      '$': PORT,
      '@enabled': true,
    },
    vipAddress: 'prot0-service',
    dataCenterInfo: {
      '@class': 'com.netflix.appinfo.InstanceInfo$DefaultDataCenterInfo',
      name: 'MyOwn',
    }
  },
  eureka: {
    host: 'localhost',         // Eureka server host
    port: 8761,                // Eureka server port
    servicePath: '/eureka/apps/',
  },
});

// Start Eureka client to register with the server
client.start(error => {
  if (error) {
    console.error('Error starting Eureka client:', error);
  } else {
    console.log('Eureka client started and registered with the discovery server');
  }
});
// Health check endpoint
app.get(`${contextPath}/info`, (req, res) => {
  res.send({ status: 'UP', message: `Service is running with context path ${contextPath}` });
});


mongoose.set("strictQuery", false);
mongoose
  .connect(process.env.MONGO_URL)
  .then(() => {
    app.listen(PORT, () => console.log(`Server Port: ${PORT}`));

    /* ONLY ADD DATA ONE TIME */
    // AffiliateStat.insertMany(dataAffiliateStat);
    // OverallStat.insertMany(dataOverallStat);
    // Product.insertMany(dataProduct);
    // ProductStat.insertMany(dataProductStat);
    // Transaction.insertMany(dataTransaction);
    // User.insertMany(dataUser);
  })
  .catch((error) => console.log(`${error} did not connect`));
