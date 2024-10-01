// color design tokens export
export const tokensDark = {
  grey: {
    0: "#ffffff", // manually adjusted
    10: "#f6f6f6", // manually adjusted
    50: "#f0f0f0", // manually adjusted
    100: "#e0e0e0",
    200: "#c2c2c2",
    300: "#a3a3a3",
    400: "#858585",
    500: "#666666",
    600: "#525252",
    700: "#3d3d3d",
    800: "#292929",
    900: "#141414",
    1000: "#000000", // manually adjusted
  },
  primary: {
    // blue
    100: "#d3d4de",
    200: "#a6a9be",
    300: "#7a7f9d",
    400: "#4d547d",
    500: "#21295c",
    600: "#191F45", // manually adjusted
    700: "#141937",
    800: "#0d1025",
    900: "#070812",
  },
  secondary: {
    // yellow
    50: "#f0f0f0", // manually adjusted
    100: "#fff6e0",
    200: "#ffedc2",
    300: "#ffe3a3",
    400: "#ffda85",
    500: "#ffd166",
    600: "#cca752",
    700: "#997d3d",
    800: "#665429",
    900: "#332a14",
  },
  greenAccent: {
    100: "#dbf5ee",
    200: "#b7ebde",
    300: "#94e2cd",
    400: "#70d8bd",
    500: "#4cceac",
    600: "#148552",
    700: "#2e7c67",
    800: "#1e5245",
    900: "#0f2922",
  },
  redAccent: {
    100: "#f8dcdb",
    200: "#f1b9b7",
    300: "#e99592",
    400: "#e2726e",
    500: "#db4f4a",
    600: "#af3f3b",
    700: "#832f2c",
    800: "#58201e",
    900: "#2c100f",
  },
  blueAccent: {
    100: "#e1e2fe",
    200: "#c3c6fd",
    300: "#a4a9fc",
    400: "#868dfb",
    500: "#6870fa",
    600: "#535ac8",
    700: "#3e4396",
    800: "#2a2d64",
    900: "#151632",
  },  
};

// function that reverses the color palette
function reverseTokens(tokensDark) {
  const reversedTokens = {};
  Object.entries(tokensDark).forEach(([key, val]) => {
    const keys = Object.keys(val);
    const values = Object.values(val);
    const length = keys.length;
    const reversedObj = {};
    for (let i = 0; i < length; i++) {
      reversedObj[keys[i]] = values[length - i - 1];
    }
    reversedTokens[key] = reversedObj;
  });
  return reversedTokens;
}
export const tokensLight = reverseTokens(tokensDark);

// mui theme settings
export const themeSettings = (mode) => {
  return {
    components: {
      MuiCssBaseline: {
        styleOverrides: {
          html: {
            '& ::-webkit-scrollbar': {
              backgroundColor: tokensDark.grey[100],
            },
            '& ::-webkit-scrollbar-track': {
              backgroundColor: tokensDark.grey[100],
            },
            '& ::-webkit-scrollbar-thumb': {
              borderRadius: 8,
              border: "none",
              backgroundColor: tokensDark.grey[0],
            },
            '& ::-webkit-scrollbar-track:hover': {
              backgroundColor: tokensDark.grey[100],
            },            
            '& ::-webkit-scrollbar-thumb:hover': {
              backgroundColor: tokensDark.secondary[600],
            },
          },
        },
      },
    },    
    palette: {
      mode: mode,
      ...(mode === "dark"
        ? {
            // palette values for dark mode
            primary: {
              ...tokensDark.primary,
              main: tokensDark.primary[400],
              light: tokensDark.primary[100],
              gradient: "linear-gradient(-90deg, #2a2185 14.848712496895075%, #002868 70.24578650224022%)",
            },
            secondary: {
              ...tokensDark.secondary,
              main: tokensDark.secondary[300],
            },   
            redAccent: {
              ...tokensDark.redAccent,
              main: tokensDark.redAccent[800],
              light: tokensDark.redAccent[300],
            },
            greenAccent: {
              ...tokensDark.greenAccent,
              main: tokensDark.greenAccent[600],
              light: tokensDark.greenAccent[300],
            },         
            blueAccent: {
              ...tokensDark.blueAccent,
              main: tokensDark.blueAccent[900],
              light: tokensDark.blueAccent[300],
            },                                
            neutral: {
              ...tokensDark.grey,
              main: tokensDark.grey[700],
              dark: tokensDark.grey[1000],
              medium: tokensDark.grey[500],
            },
            background: {
              default: tokensDark.primary[600],
              alt: tokensDark.primary[500],
            },          
          }
        : {
            // palette values for light mode
            primary: {
              ...tokensLight.primary,
              main: tokensDark.grey[50],
              light: tokensDark.grey[100],
              gradient: "linear-gradient(180deg, #2a2185 18%, #002868 80%)",
            },
            secondary: {
              ...tokensLight.secondary,
              main: tokensDark.secondary[600],
              light: tokensDark.secondary[700],
            }, 
            redAccent: {
              ...tokensLight.redAccent,
              main: tokensDark.redAccent[500],
              light: tokensDark.redAccent[300],
            },                
            greenAccent: {
              ...tokensLight.greenAccent,
              main: tokensDark.greenAccent[700],
              light: tokensDark.greenAccent[100],
            },            
            blueAccent: {
              ...tokensLight.blueAccent,
              main: tokensDark.blueAccent[100],
              light: tokensDark.blueAccent[300],
            },                       
            neutral: {
              ...tokensLight.grey,
              main: tokensDark.grey[200],
              dark: tokensDark.grey[800],
              medium: tokensDark.grey[600],
            },
            background: {
              default: tokensDark.grey[100],
              alt: tokensDark.grey[0],
            },           
          }),
    },
    typography: {
      fontFamily: ["Inter", "sans-serif"].join(","),
      fontSize: 12,
      h1: {
        fontFamily: ["Helvetica","sans-serif"].join(","),
        fontSize: 40,
      },
      h2: {
        fontFamily: ["Helvetica","sans-serif"].join(","),
        fontSize: 32,
      },
      h3: {
        fontFamily: ["Helvetica","sans-serif"].join(","),
        fontSize: 24,
      },
      h4: {
        fontFamily: ["Helvetica","sans-serif"].join(","),
        fontSize: 20,
      },
      h5: {
        fontFamily: ["Helvetica","sans-serif"].join(","),
        fontSize: 16,
      },
      h6: {
        fontFamily: ["Inter", "sans-serif"].join(","),
        fontSize: 14,
      },
      h7: {
        fontFamily: ["Inter", "sans-serif"].join(","),
        fontSize: 12,
      },      
    },
  };
};
