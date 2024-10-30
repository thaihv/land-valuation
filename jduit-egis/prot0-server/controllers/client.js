import bcrypt from "bcrypt";
import Product from "../models/Product.js";
import ProductStat from "../models/ProductStat.js";
import User from "../models/User.js";
import Transaction from "../models/Transaction.js";
import getCountryIso3 from "country-iso-2-to-3";

export const getProducts = async (req, res) => {
  try {
    const products = await Product.find();

    const productsWithStats = await Promise.all(
      products.map(async (product) => {
        const stat = await ProductStat.find({
          productId: product._id,
        });
        return {
          ...product._doc,
          stat,
        };
      })
    );

    res.status(200).json(productsWithStats);
  } catch (error) {
    res.status(404).json({ message: error.message });
  }
};

export const getCustomers = async (req, res) => {
  try {
    // sort should look like this: { "field": "userId", "sort": "desc"}
    const { page = 1, pageSize = 20, sort = null, search = "" } = req.query;
    // formatted sort should look like { userId: -1 }
    const generateSort = () => {
      const sortParsed = JSON.parse(sort);
      const sortFormatted = {
        [sortParsed.field]: (sortParsed.sort = "asc" ? 1 : -1),
      };

      return sortFormatted;
    };
    const sortFormatted = Boolean(sort) ? generateSort() : {};

    const customers = await User.find({
      $and: [
        { role: "user" },
        {       
          $or: [
            { name: { $regex: new RegExp(search, "i") } },
            { email: { $regex: new RegExp(search, "i") } },
            { phoneNumber: { $regex: new RegExp(search, "i") } },
            { country: { $regex: new RegExp(search, "i") } },
            { occupation: { $regex: new RegExp(search, "i") } },
          ], 
      }
      ],
    })
      .select("-password")
      .sort(sortFormatted)
      .skip(page * pageSize)
      .limit(pageSize);
      
    let total = await User.find({ role: "user" }).countDocuments();  
    if (search){
      total = await User.find({
        $and: [
          { role: "user" },
          {       
            $or: [
              { name: { $regex: new RegExp(search, "i") } },
              { email: { $regex: new RegExp(search, "i") } },
              { phoneNumber: { $regex: new RegExp(search, "i") } },
              { country: { $regex: new RegExp(search, "i") } },
              { occupation: { $regex: new RegExp(search, "i") } },
            ], 
        }
        ],
      }).countDocuments();    
    }      
    res.status(200).json({
      customers,
      total,
    });
  } catch (error) {
    res.status(404).json({ message: error.message });
  }
};
export const getCustomer = async (req, res) => {
  try {
    const { id } = req.params;
    const Customer = await User.findById(id);
    res.status(200).json({
      Customer
    });
  } catch (error) {
    res.status(404).json({ message: error.message });
  }
};
export const addCustomer = async (req, res) => {
  try {
    const {
      name,
      email,
      country,
      phoneNumber,
      occupation,
      role,
    } = req.body;

    const salt = await bcrypt.genSalt();
    const passwordHash = await bcrypt.hash('123456', salt);

    const newUser = new User({
      name,
      email,
      password: passwordHash,
      country,
      phoneNumber,
      occupation,
      role,
    });
    const savedCustomer = await newUser.save();
    res.status(201).json(savedCustomer);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
export const updateCustomer = async (req, res) => {
  const {
    _id,
    name,
    email,
    country,
    phoneNumber,
    occupation,
    role,
  } = req.body;
  const customer = await User.findOne({ _id: _id });
  if (customer) {
    customer.name = name;
    customer.email = email;
    customer.phoneNumber = phoneNumber;
    customer.occupation  = occupation;
    customer.country = country;
    customer.role     = role;
    try {
      await customer.save();
      res.status(201).json(customer);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }    
  }
  else {
    res.status(500).json({ error: "Could not load customer" });
  }
};
export const deleteCustomer = async (req, res) => {
  try {  
    const { id } = req.params;    
    const deletedCount = await User.findByIdAndDelete(id);
    res.status(200).json({
      deletedCount
    });
  } catch (error) {
    res.status(404).json({ message: error.message });
  }
};

export const getTransactions = async (req, res) => {
  try {
    // sort should look like this: { "field": "userId", "sort": "desc"}
    const { page = 1, pageSize = 20, sort = null, search = "" } = req.query;

    // formatted sort should look like { userId: -1 }
    const generateSort = () => {
      const sortParsed = JSON.parse(sort);
      const sortFormatted = {
        [sortParsed.field]: (sortParsed.sort = "asc" ? 1 : -1),
      };

      return sortFormatted;
    };
    const sortFormatted = Boolean(sort) ? generateSort() : {};
    const transactions = await Transaction.find({
      $or: [
        { cost: { $regex: new RegExp(search, "i") } },
        { userId: { $regex: new RegExp(search, "i") } },
      ],
    })
      .sort(sortFormatted)
      .skip(page * pageSize)
      .limit(pageSize);
      
    let total = await Transaction.countDocuments();  
    if (search){
      total = await Transaction.find({
        $or: [
          { cost: { $regex: new RegExp(search, "i") } },
          { userId: { $regex: new RegExp(search, "i") } },
        ],
      }).countDocuments();
    }      
    res.status(200).json({
      transactions,
      total,
    });
  } catch (error) {
    res.status(404).json({ message: error.message });
  }
};

export const getGeography = async (req, res) => {
  try {
    const users = await User.find();

    const mappedLocations = users.reduce((acc, { country }) => {
      const countryISO3 = getCountryIso3(country);
      if (!acc[countryISO3]) {
        acc[countryISO3] = 0;
      }
      acc[countryISO3]++;
      return acc;
    }, {});

    const formattedLocations = Object.entries(mappedLocations).map(
      ([country, count]) => {
        return { id: country, value: count };
      }
    );

    res.status(200).json(formattedLocations);
  } catch (error) {
    res.status(404).json({ message: error.message });
  }
};
