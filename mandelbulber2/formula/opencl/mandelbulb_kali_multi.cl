/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * based on mandelbulb Kali multi
 * @reference http://www.fractalforums.com/theory/mandelbulb-variant/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 MandelbulbKaliMultiIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;

	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}
	REAL costh;
	REAL sinth;
	REAL th0 = fractal->bulb.betaAngleOffset + 1e-030f; // MUST keep exception catch
	REAL ph0 = fractal->bulb.alphaAngleOffset;
	REAL4 v;
	switch (fractal->mandelbulbMulti.orderOfXYZ)
	{
		case multi_OrderOfXYZCl_xyz:
		default: v = (REAL4){z.x, z.y, z.z, z.w}; break;
		case multi_OrderOfXYZCl_xzy: v = (REAL4){z.x, z.z, z.y, z.w}; break;
		case multi_OrderOfXYZCl_yxz: v = (REAL4){z.y, z.x, z.z, z.w}; break;
		case multi_OrderOfXYZCl_yzx: v = (REAL4){z.y, z.z, z.x, z.w}; break;
		case multi_OrderOfXYZCl_zxy: v = (REAL4){z.z, z.x, z.y, z.w}; break;
		case multi_OrderOfXYZCl_zyx: v = (REAL4){z.z, z.y, z.x, z.w}; break;
	}

	if (fractal->mandelbulbMulti.acosOrAsin == multi_acosOrAsinCl_acos)
		th0 += acos(native_divide(v.x, aux->r));
	else
		th0 += asin(native_divide(v.x, aux->r));
	if (fractal->mandelbulbMulti.atanOrAtan2 == multi_atanOrAtan2Cl_atan)
		ph0 += atan(native_divide(v.y, v.z));
	else
		ph0 += atan2(v.y, v.z);

	th0 *= fractal->transformCommon.pwr8 * fractal->transformCommon.scaleA1;

	if (fractal->transformCommon.functionEnabledBxFalse)
	{
		costh = native_cos(th0);
		z = aux->r * (REAL4){costh * native_sin(ph0), native_cos(ph0) * costh, native_sin(th0), 0.0f};
	}
	else
	{ // cosine mode default
		sinth = native_sin(th0);
		z = aux->r * (REAL4){sinth * native_cos(ph0), native_sin(ph0) * sinth, native_cos(th0), 0.0f};
	}

	if (fractal->transformCommon.functionEnabledxFalse)
	{
		switch (fractal->mandelbulbMulti.orderOfXYZ2)
		{
			case multi_OrderOfXYZCl_xyz:
			default: v = (REAL4){z.x, z.y, z.z, z.w}; break;
			case multi_OrderOfXYZCl_xzy: v = (REAL4){z.x, z.z, z.y, z.w}; break;
			case multi_OrderOfXYZCl_yxz: v = (REAL4){z.y, z.x, z.z, z.w}; break;
			case multi_OrderOfXYZCl_yzx: v = (REAL4){z.y, z.z, z.x, z.w}; break;
			case multi_OrderOfXYZCl_zxy: v = (REAL4){z.z, z.x, z.y, z.w}; break;
			case multi_OrderOfXYZCl_zyx: v = (REAL4){z.z, z.y, z.x, z.w}; break;
		}
		if (fractal->mandelbulbMulti.acosOrAsinA == multi_acosOrAsinCl_acos)
			th0 = acos(native_divide(v.x, aux->r)) + fractal->transformCommon.betaAngleOffset
						+ 1e-030f; // MUST keep exception catch
		else
			th0 += asin(native_divide(v.x, aux->r)) + fractal->transformCommon.betaAngleOffset
						 + 1e-030f; // MUST keep exception catch;

		if (fractal->mandelbulbMulti.atanOrAtan2A == multi_atanOrAtan2Cl_atan)
			ph0 += atan(native_divide(v.y, v.z));
		else
			ph0 += atan2(v.y, v.z);
	}
	else
	{
		switch (fractal->mandelbulbMulti.orderOfXYZ)
		{
			case multi_OrderOfXYZCl_xyz:
			default: v = (REAL4){z.x, z.y, z.z, z.w}; break;
			case multi_OrderOfXYZCl_xzy: v = (REAL4){z.x, z.z, z.y, z.w}; break;
			case multi_OrderOfXYZCl_yxz: v = (REAL4){z.y, z.x, z.z, z.w}; break;
			case multi_OrderOfXYZCl_yzx: v = (REAL4){z.y, z.z, z.x, z.w}; break;
			case multi_OrderOfXYZCl_zxy: v = (REAL4){z.z, z.x, z.y, z.w}; break;
			case multi_OrderOfXYZCl_zyx: v = (REAL4){z.z, z.y, z.x, z.w}; break;
		}

		if (fractal->mandelbulbMulti.acosOrAsin == multi_acosOrAsinCl_acos)
			th0 = acos(native_divide(v.x, aux->r)) + fractal->transformCommon.betaAngleOffset
						+ 1e-030f; // MUST keep exception catch ??;
		else
			th0 += asin(native_divide(v.x, aux->r)) + fractal->transformCommon.betaAngleOffset
						 + 1e-030f; // MUST keep exception catch ??;

		if (fractal->mandelbulbMulti.atanOrAtan2 == multi_atanOrAtan2Cl_atan)
			ph0 += atan(native_divide(v.y, v.z));
		else
			ph0 += atan2(v.y, v.z);
	}

	ph0 *= fractal->transformCommon.pwr8 * fractal->transformCommon.scaleB1 * 0.5f; // 0.5f retain
	REAL zp = native_powr(aux->r, fractal->transformCommon.pwr8);

	if (fractal->transformCommon.functionEnabledzFalse)
	{ // sine mode
		costh = native_cos(th0);
		z = zp * (REAL4){costh * native_sin(ph0), native_cos(ph0) * costh, native_sin(th0), 0.0f};
	}
	else
	{ // cosine mode default
		sinth = native_sin(th0);
		z = zp * (REAL4){sinth * native_cos(ph0), native_sin(ph0) * sinth, native_cos(th0), 0.0f};
	}

	if (fractal->analyticDE.enabledFalse)
	{ // analytic log DE adjustment
		aux->r_dz = mad(native_powr(aux->r, fractal->transformCommon.pwr8 - fractal->analyticDE.offset1)
											* aux->r_dz * fractal->transformCommon.pwr8,
			fractal->analyticDE.scale1, fractal->analyticDE.offset2);
	}
	else // default, i.e. scale1 & offset1 & offset2 = 1.0f
	{
		aux->r_dz =
			mad(native_powr(aux->r, fractal->transformCommon.pwr8 - 1.0f) * fractal->transformCommon.pwr8,
				aux->r_dz, 1.0f);
	}
	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZC)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZC)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplierC111;
	}
	return z;
}