import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import User from "../models/User.js";

/* REGISTER USER */
export const register = async (req, res) => {
  try {
    const {
      name,
      email,
      password,
      city,
      state,
      country,
      phoneNumber,
      picturePath,
      occupation,
      transactions,
      role,
    } = req.body;

    const salt = await bcrypt.genSalt();
    const passwordHash = await bcrypt.hash(password, salt);

    const newUser = new User({
      name,
      email,
      password: passwordHash,
      city,
      state,
      country,
      phoneNumber,
      picturePath,
      occupation,
      transactions,
      role,
    });
    const savedUser = await newUser.save();
    res.status(201).json(savedUser);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
export const update_register = async (req, res) => {
  const {
    name,
    email,
    password,
    city,
    state,
    country,
    phoneNumber,
    picturePath,
    occupation,
    transactions,
    role,
  } = req.body;

  const user = await User.findOne({ email: email });

  if (user) {
    user.name = name;
    user.city = city;
    user.phoneNumber = phoneNumber;
    user.occupation  = occupation;
    user.picturePath = picturePath;
    user.picture     = req.picture;
    
    const salt = await bcrypt.genSalt();
    const passwordHash = await bcrypt.hash(password, salt);
    user.password = passwordHash;

    user.save(function(err) {
      if (err)
        { res.status(500).json({ error: err.message }); }
      else
        { res.status(201).json(user); }
    });
  }
  else {
    res.status(500).json({ error: "Could not load Document" });
  }

};
/* LOGGING IN */
export const login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email: email });
    if (!user) return res.status(400).json({ msg: "User does not exist. " });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ msg: "Invalid credentials. " });

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET);
    delete user.password;
    res.status(200).json({ token, user });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
