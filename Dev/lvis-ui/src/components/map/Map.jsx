import { MapContainer, TileLayer } from 'react-leaflet'
import { useState } from "react";
import './map.scss'
import "leaflet/dist/leaflet.css";
import Pin from './Pin';

function Map({items}){
  const [center, setCenter] = useState({ lat: 19.8563, lng: 102.4955 });
  const ZOOM_LEVEL = 6;
  return (
    <MapContainer center={center} zoom={ZOOM_LEVEL} scrollWheelZoom={true} className='map'>
    <TileLayer
      attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
    />
    {items.map(item=>(
      <Pin item={item} key={item.id}/>
    ))}
  </MapContainer>
  )
}

export default Map