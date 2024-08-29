import { useEffect } from "react";
import L from "leaflet";
import "leaflet/dist/leaflet.css";

export default function CustomMap() {
  useEffect(() => {
    const map = L.map("map", { zoomControl: false }).setView(
      [17.9667, 102.6],
      11
    );
    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    }).addTo(map);

    return () => {
      map.off();
      map.remove();
    };
  }, []);
  return <div id="map" style={{ height: "100%", zIndex: 0 }}></div>;
}
