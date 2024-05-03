package com.jdvn.devtech.util.performance.regression;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static tec.units.ri.unit.Units.LITRE;
import static tec.units.ri.unit.Units.METRE;
import static tec.units.ri.unit.Units.NEWTON;
import static tec.units.ri.unit.Units.SECOND;
import static tec.units.ri.unit.Units.WATT;

import javax.measure.Quantity;
import javax.measure.Unit;
import javax.measure.UnitConverter;
import javax.measure.quantity.Area;
import javax.measure.quantity.Length;
import javax.measure.quantity.Pressure;
import javax.measure.quantity.Volume;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import com.jdvn.devtech.datamodel.DatamodelApplication;

import tec.units.ri.format.SimpleUnitFormat;
import tec.units.ri.quantity.Quantities;
import tec.units.ri.unit.MetricPrefix;

@SpringBootTest(classes = DatamodelApplication.class)
public class QuantityAndUnitTest {
	public class WaterTank {

		private Quantity<Volume> capacityMeasure;
		private double capacityDouble;

		public void setCapacityMeasure(Quantity<Volume> capacityMeasure) {
			this.capacityMeasure = capacityMeasure;
		}

		public void setCapacityDouble(double capacityDouble) {
			this.capacityDouble = capacityDouble;
		}

		public Quantity<Volume> getCapacityMeasure() {
			return capacityMeasure;
		}

		public double getCapacityDouble() {
			return capacityDouble;
		}
	}

	@Test
	public void givenQuantity_whenGetUnitAndConvertValue_thenSuccess() {
		WaterTank waterTank = new WaterTank();
		waterTank.setCapacityMeasure(Quantities.getQuantity(9.2, LITRE));
		assertEquals(LITRE, waterTank.getCapacityMeasure().getUnit());

		Quantity<Volume> waterCapacity = waterTank.getCapacityMeasure();
		double volumeInLitre = waterCapacity.getValue().doubleValue();
		assertEquals(9.2, volumeInLitre, 0.0f);

		double volumeInMilliLitre = waterCapacity.to(MetricPrefix.MILLI(LITRE)).getValue().doubleValue();
		assertEquals(9200.0, volumeInMilliLitre, 0.0f);
	}

	@Test
	public void givenUnit_whenAlternateUnit_ThenGetAlternateUnit() {

		Unit<Pressure> PASCAL = NEWTON.divide(METRE.pow(2)).alternate("Pa").asType(Pressure.class);
		assertTrue(SimpleUnitFormat.getInstance().parse("Pa").equals(PASCAL));
	}

	@Test
	public void givenUnit_whenProduct_ThenGetProductUnit() {
		Unit<Area> squareMetre = METRE.multiply(METRE).asType(Area.class);
		Quantity<Length> line = Quantities.getQuantity(2, METRE);
		assertEquals(line.multiply(line).getUnit(), squareMetre);
	}

	@Test
	public void givenMeters_whenConvertToKilometer_ThenConverted() {
		double distanceInMeters = 50.0;
		UnitConverter metreToKilometre = METRE.getConverterTo(MetricPrefix.KILO(METRE));
		double distanceInKilometers = metreToKilometre.convert(distanceInMeters);
		assertEquals(0.05, distanceInKilometers, 0.00f);
	}

	@Test
	public void givenSymbol_WhenCompareToSystemUnit_ThenSuccess() {
		assertTrue(SimpleUnitFormat.getInstance().parse("kW").equals(MetricPrefix.KILO(WATT)));
		assertTrue(SimpleUnitFormat.getInstance().parse("ms").equals(SECOND.divide(1000)));
	}

	@Test
	public void givenUnits_WhenAdd_ThenSuccess() {
		Quantity<Length> total = Quantities.getQuantity(2, METRE).add(Quantities.getQuantity(3, METRE));
		assertEquals(total.getValue().intValue(), 5);

		Quantity<Length> totalKm = Quantities.getQuantity(2, METRE)
				.add(Quantities.getQuantity(3, MetricPrefix.KILO(METRE)));
		assertEquals(totalKm.getValue().intValue(), 3002);
	}

}