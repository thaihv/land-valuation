import React, { useState} from "react";
import {
  Box,
  Checkbox,
  FormControlLabel, 
  TextField,
  useMediaQuery,
  Typography,
  useTheme,
} from "@mui/material";
import StyledButton from "../../components/custom/StyledButton"
import Dropzone from "react-dropzone";
import { Formik } from "formik";
import * as yup from "yup";
import FlexBetween from "../../components/FlexBetween";
import EditOutlinedIcon from "@mui/icons-material/EditOutlined";

const registerSchema = yup.object().shape({
  name: yup.string()
    .min(2, 'Too Short!')
    .max(60, 'Too Long!')
    .required("Name is required"),
  email: yup.string().email("invalid email").required("Email is required"),
  password: yup.string().notRequired(),
  changepassword: yup.boolean(),
  city: yup.string().required("required"),
  phoneNumber: yup.string().required("required"),
  occupation: yup.string().required("required"),
  picture: yup.string().notRequired(),

});

const UpdateUser = ({user}) => {
  const isNonMobile = useMediaQuery("(min-width:600px)");
  const theme = useTheme();
  const update_register = async (values, onSubmitProps) => {
    console.log(values);
    // this allows us to send form info with image
    const formData = new FormData();
    for (let value in values) {
      formData.append(value, values[value]);
    }
    if (values.picture){
      formData.delete("picturePath", "");
      formData.append("picturePath", values.picture.name);
    }
    const savedUserResponse = await fetch(
      `${import.meta.env.VITE_REACT_APP_BASE_URL}/auth/register`,
      {
        method: "PUT",
        body: formData,
      }
    );
    const savedUser = await savedUserResponse.json();
    onSubmitProps.resetForm();

    if (savedUser) {
      console.log('update ok!');
    }
  };


  const handleFormSubmit = async (values, onSubmitProps) => {
    await update_register(values, onSubmitProps);
  };

  return (
    <Formik
      onSubmit={handleFormSubmit}
      initialValues={user}
      validationSchema={registerSchema}
    >
      {({
        values,
        errors,
        touched,
        handleBlur,
        handleChange,
        handleSubmit,
        setFieldValue,
      }) => (
        <form onSubmit={handleSubmit}>
          <Box 
            sx={{
              padding: "2.5rem 1.5rem 0.75rem 1.5rem",
              backgroundColor: theme.palette.background.alt,
              borderRadius: "0.75rem",
            }}
          >          
            <Box
              display="grid"
              gap="20px"
              gridTemplateColumns="repeat(4, minmax(0, 1fr))"
              sx={{
                "& > div": { gridColumn: isNonMobile ? undefined : "span 4" },
              }}
            >
              <>
                <TextField
                  label="Name"
                  onBlur={handleBlur}
                  onChange={handleChange}
                  value={values.name || ''}
                  name="name"
                  error={Boolean(touched.name) && Boolean(errors.name)}
                  helperText={touched.name && errors.name}
                  sx={{ gridColumn: "span 4" }}
                />
                <TextField
                  label="City"
                  onBlur={handleBlur}
                  onChange={handleChange}
                  value={values.city || ''}
                  name="city"
                  error={Boolean(touched.city) && Boolean(errors.city)}
                  helperText={touched.city && errors.city}
                  sx={{ gridColumn: "span 4" }}
                />
                <TextField
                  label="Phone Number"
                  onBlur={handleBlur}
                  onChange={handleChange}
                  value={values.phoneNumber || ''}
                  name="phoneNumber"
                  error={
                    Boolean(touched.phoneNumber) && Boolean(errors.phoneNumber)
                  }
                  helperText={touched.phoneNumber && errors.phoneNumber}
                  sx={{ gridColumn: "span 2" }}
                />
                <TextField
                  label="Occupation"
                  onBlur={handleBlur}
                  onChange={handleChange}
                  value={values.occupation || ''}
                  name="occupation"
                  error={
                    Boolean(touched.occupation) && Boolean(errors.occupation)
                  }
                  helperText={touched.occupation && errors.occupation}
                  sx={{ gridColumn: "span 2" }}
                />
                <Box
                  gridColumn="span 4"
                  border={`1px solid ${theme.palette.neutral.main}`}
                  borderRadius="5px"
                  p="1rem"
                >
                  <Dropzone
                    acceptedFiles=".jpg,.jpeg,.png"
                    multiple={false}
                    onDrop={(acceptedFiles) =>
                      setFieldValue("picture", acceptedFiles[0])
                    }
                  >
                    {({ getRootProps, getInputProps }) => (
                      <Box
                        {...getRootProps()}
                        border={`2px dashed ${theme.palette.neutral.dark}`}
                        p="1rem"
                        sx={{ "&:hover": { cursor: "pointer" } }}
                      >
                        <input {...getInputProps()} />
                        {!values.picture ? (
                          <p>Add Profile Picture Here</p>
                        ) : (
                          <FlexBetween>
                            <Typography>{values.picture.name}</Typography>
                            <EditOutlinedIcon />
                          </FlexBetween>
                        )}
                      </Box>
                    )}
                  </Dropzone>
                </Box>                                
              </>

              <TextField
                label="Email"
                onBlur={handleBlur}
                onChange={handleChange}
                value={values.email || ''}
                name="email"
                error={Boolean(touched.email) && Boolean(errors.email)}
                helperText={touched.email && errors.email}
                sx={{ gridColumn: "span 4" }}
              />
              <TextField
                label="Password"
                type="password"
                disabled={values.changepassword ? false : true}
                onBlur={handleBlur}
                onChange={handleChange}
                value={values.password || ''}
                name="password"
                error={Boolean(touched.password) && Boolean(errors.password)}
                helperText={touched.password && errors.password}
                sx={{ gridColumn: "span 3" }}
              />
              <FormControlLabel 
                control={
                  <Checkbox 
                    onBlur={handleBlur}
                    onChange={handleChange}
                    name="changepassword"
                    value={values.changepassword || ''}
                    inputProps={{ "aria-label": "primary checkbox" }}
                  />} 
                label="Change Password" 
                sx={{ gridColumn: "span 1" }} 
              />
            </Box>

            {/* BUTTONS */}
            <Box>
              <StyledButton
                fullWidth
                type="submit"
                sx={{
                  m: "2rem 0",
                  p: "1rem",
                  backgroundColor: theme.palette.background.default,
                  color: theme.palette.neutral.dark,
                  "&:hover": { color: theme.palette.secondary.main },
                }}
              >
                Update
              </StyledButton>
            </Box>
          </Box>
        </form>
      )}
    </Formik>
  );
};

export default UpdateUser;
