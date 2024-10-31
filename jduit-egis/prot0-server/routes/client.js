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
import { keycloak } from '../keycloak-config.js';

const router = express.Router();

router.get("/products", getProducts);
router.get("/customers", keycloak.protect(), getCustomers);

router.get("/customers/:id", getCustomer);
router.delete("/customers/:id", keycloak.protect('Admin'), deleteCustomer);
router.post('/customers', keycloak.protect('Admin'), addCustomer);
router.put('/customers/:id', keycloak.protect('Admin'), updateCustomer);

router.get("/transactions", keycloak.protect(), getTransactions);
router.get("/geography", keycloak.protect(), getGeography);

export default router;
