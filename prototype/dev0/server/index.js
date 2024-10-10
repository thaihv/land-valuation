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
import authRoutes from "./routes/auth.js";
import { register, update_register } from "./controllers/auth.js";
import { createPost } from "./controllers/posts.js";
import managementRoutes from "./routes/management.js";
import salesRoutes from "./routes/sales.js";
import postRoutes from "./routes/posts.js";
import { verifyToken } from "./middleware/auth.js";

// data imports
import User from "./models/User.js";
import Post from "./models/Post.js";
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
  posts,
} from "./data/index.js";

/* CONFIGURATIONS */
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config();
const app = express();
app.use(express.json());
app.use(helmet());
app.use(helmet.crossOriginResourcePolicy({ policy: "cross-origin" }));
app.use(morgan("common"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cors());
app.use("/profiles", express.static(path.join(__dirname, "public/profiles")));
app.use("/assets", express.static(path.join(__dirname, "public/assets")));
app.use("/uploads", express.static(path.join(__dirname, "uploads")));
/* FILE STORAGE */
const storage_profiles = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./public/profiles");
  },
  filename: function (req, file, cb) {
    cb(null, req.body.email + '_' + file.originalname);
  },
});
const storage_uploads = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./uploads");
  },
  filename: function (req, file, cb) {
    cb(null,  Date.now() + '-' +  file.originalname);
  },
});
const profiles_upload = multer({ storage: storage_profiles });
const data_upload = multer({ storage: storage_uploads });

/* ROUTES WITH FILES */
// For upload profiles
app.post("/auth/register", profiles_upload.single("picture"), register);
app.put("/auth/register", profiles_upload.single("picture"), update_register);

// For upload any data into uploads folder
app.post('/uploads', data_upload.single('file'), (req, res) => {
  console.log('body', req.file)
  // here you can do anything that you want for the file such as you want to save it to database here
  res.json({ success: true })
})
app.post("/posts", verifyToken, data_upload.single("picture"), createPost);

/* ROUTES */
app.use("/auth", authRoutes);
app.use("/client", clientRoutes);
app.use("/general", generalRoutes);
app.use("/management", managementRoutes);
app.use("/sales", salesRoutes);
app.use("/posts", postRoutes);
/* MONGOOSE SETUP */
const PORT = process.env.PORT || 9000;
mongoose.set("strictQuery", false);
mongoose
  .connect(process.env.MONGO_URL)
  .then(() => {
    app.listen(PORT, () => console.log(`Server Port: ${PORT}`));

    /* ONLY ADD DATA ONE TIME */
    AffiliateStat.insertMany(dataAffiliateStat);
    OverallStat.insertMany(dataOverallStat);
    Product.insertMany(dataProduct);
    ProductStat.insertMany(dataProductStat);
    Transaction.insertMany(dataTransaction);
    User.insertMany(dataUser);
    Post.insertMany(posts);
  })
  .catch((error) => console.log(`${error} did not connect`));
