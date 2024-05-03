package com.jdvn.devtech.util.performance.regression;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.math.NumberUtils;

public class ValuationNumberUtils {
	public static long getLongValue(Object numObj) {
		String numObjStr = ObjectUtils.toString(numObj);
		return NumberUtils.toLong(numObjStr);
	}

	public static double getDoubleValue(Object numObj) {
		String numObjStr = ObjectUtils.toString(numObj);
		return NumberUtils.toDouble(numObjStr);
	}

	public static int getIntValue(Object numObj) {
		String numObjStr = ObjectUtils.toString(numObj);
		return NumberUtils.toInt(numObjStr);
	}

	public static boolean isValidContinuos(double min1, double max1, double min2, double max2) {
		if ((max1 <= min2 || max2 <= min1) && min1 >= 0 && max1 >= 0 && min2 >= 0 && max2 >= 0)
			return true;
		return false;
	}

	public static double calcLogeValue(double beta1, double beta2) {
		double result = 0;
		if (beta1 == beta2)
			result = 1;
		else if (Math.abs(beta1 - beta2) > 50) // TODO: ratio too much => temp value = 0
			result = 0;
		else
			result = Math.pow(Math.E, (beta1 - beta2));

		// Làm tròn 2 chữ số thập phân
		result = Math.round(result * 100.0) / 100.0;
		return result;
	}
}
