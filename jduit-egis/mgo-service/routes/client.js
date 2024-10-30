import express from "express";
import {
  getProducts,
  getCustomer,
  getCustomers,
  addCustomer,
  updateCustomer,
  deleteCustomer,
  getTransactions,
  getGeography,
} from "../controllers/client.js";

const router = express.Router();

router.get("/products", getProducts);
router.get("/customers", getCustomers);

router.get("/customers/:id", getCustomer);
router.delete("/customers/:id", deleteCustomer);
router.post('/customers', addCustomer);
router.put('/customers/:id', updateCustomer);

router.get("/transactions", getTransactions);
router.get("/geography", getGeography);

export default router;
