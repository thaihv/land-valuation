import { useEffect } from 'react'
import { Box, useTheme } from "@mui/material";
import { useGetGeographyQuery } from "../../../state/prototypeApi";
import { ResponsiveChoropleth } from "@nivo/geo";
import { geoData } from "../../../data/geoData";

const Geography = () => {
  const theme = useTheme();
  const { data } = useGetGeographyQuery();

  useEffect(() => {
    const originalConsoleWarn = console.error
    console.error = (message, ...args) => {
      if (
        message.includes('Warning: Failed %s type: %s%s')
      ) {
        return
      }
      originalConsoleWarn(message, ...args)
    }
    return () => {
      // Restore original console.error on cleanup
      console.error = originalConsoleWarn
    }
  }, [])

  const onFeatureClick = (feature) => {
    console.log(feature.data);
  };

  return (
    <Box
      height="70vh"
      border={`1px solid ${theme.palette.secondary[200]}`}
      borderRadius="4px"
    >
      {data ? (
        <ResponsiveChoropleth
          data={data}
          theme={{
            axis: {
              domain: {
                line: {
                  stroke: theme.palette.secondary[200],
                },
              },
              legend: {
                text: {
                  fill: theme.palette.secondary[200],
                },
              },
              ticks: {
                line: {
                  stroke: theme.palette.secondary[200],
                  strokeWidth: 1,
                },
                text: {
                  fill: theme.palette.secondary[200],
                },
              },
            },
            legends: {
              text: {
                fill: theme.palette.secondary[200],
              },
            },
            tooltip: {
              container: {
                color: theme.palette.secondary[500],
              },
            },
          }}
          features={geoData.features}
          margin={{ top: 0, right: 0, bottom: 0, left: -50 }}
          domain={[0, 60]}
          colors="PuOr"
          fillColor={theme.palette.secondary[500]}
          unknownColor="nivo"
          label="properties.name"
          valueFormat=".2s"
          enableGraticule={true}
          graticuleLineColor={theme.palette.secondary[200]}
          graticuleLineWidth={0.5}
          onClick={onFeatureClick}
          projectionType="mercator"
          isInteractive={true}
          projectionScale={150}
          projectionTranslation={[0.45, 0.6]}
          projectionRotation={[0, 0, 0]}
          borderWidth={1.3}
          borderColor="#ffffff"
          defs={[
            {
              id: 'dots',
              type: 'patternDots',
              background: 'inherit',
              color: '#38bcb2',
              size: 4,
              padding: 1,
              stagger: true
            },
            {
              id: 'lines',
              type: 'patternLines',
              background: 'inherit',
              color: '#eed312',
              rotation: -45,
              lineWidth: 6,
              spacing: 10
            },
            {
              id: 'gradient',
              type: 'linearGradient',
              colors: [
                {
                  offset: 0,
                  color: '#000'
                },
                {
                  offset: 100,
                  color: 'inherit'
                }
              ]
            }
          ]}
          fill={[
            {
              match: {
                id: 'CHN'
              },
              id: 'dots'
            },
            {
              match: {
                id: 'VNM'
              },
              id: 'lines'
            },
            {
              match: {
                id: 'ATA'
              },
              id: 'gradient'
            }
          ]}
          legends={[
            {
              anchor: "bottom-right",
              direction: "column",
              justify: true,
              translateX: 0,
              translateY: -125,
              itemsSpacing: 0,
              itemWidth: 94,
              itemHeight: 18,
              itemDirection: "left-to-right",
              itemTextColor: theme.palette.secondary[200],
              itemOpacity: 0.85,
              symbolSize: 18,
              effects: [
                {
                  on: "hover",
                  style: {
                    itemTextColor: theme.palette.secondary[500],
                    itemOpacity: 1,
                  },
                },
              ],
            },
          ]}
        />
      ) : (
        <>Loading...</>
      )}
    </Box>
  );
};

export default Geography;
