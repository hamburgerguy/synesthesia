vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

float circle(vec2 st, vec2 center, float radius) {
  return smoothstep(1., 1.-0.025, distance(st, center) / radius);
}

float ring(vec2 st, vec2 center, float radius) {
	return circle(st, center, radius) - circle(st, center, radius - 0.020);
}

vec4 renderMain(void)
{
	// vec2 position = _uv; used for position x and position y

	//vec2 st = (2.*fragCoord.xy - iResolution.xy)/iResolution.y;
	vec2 st = _uv;
	vec3 color = vec3(0.0);
	vec3 color2 = vec3(0.0);
	vec3 color3 = vec3(0.0);
	vec3 color4 = vec3(0.0);
  vec3 color5 = vec3(0.0);

	float r = 0.25,
			a = atan(st.y, st.x),
			noiseA = a + TIME;

	vec2 nPos = vec2(cos(noiseA), sin(noiseA));

	float n = noise(nPos),
			n2 = noise(nPos + syn_BassHits);

	r += sin(a*10.) * n*.18;
	r += sin(a*30.) * n2*.08;

  float r1 = r;
  float r2 = r-0.1;
  float r3 = r+0.1;
  float r4 = r+0.15;
  float r5 = r+0.22;

	float pct = ring(st, vec2(0.5,0.5), r1);
	color = vec3(0.9, 0.9, 0.9) * pct + vec3(0.1, 0.1, 0.1) * pct * n * 2.;

	float pct2 = ring(st, vec2(0.5,0.5), r2);
	color2 = vec3(0.9, 0.9, 0.9) * pct2 + vec3(0.1, 0.1, 0.1) * pct2 * n * 2.;

	float pct3 = ring(st, vec2(0.5,0.5), r3);
	color3 = vec3(0.9, 0.9, 0.9) * pct3 + vec3(0.1, 0.1, 0.1) * pct3 * n * 2.;

	float pct4 = ring(st, vec2(0.5,0.5), r4);
	color4 = vec3(0.9, 0.9, 0.9) * pct4 + vec3(0.1, 0.1, 0.1) * pct4 * n * 2.;

  float pct5 = ring(st, vec2(0.5,0.5), r5);
	color5 = vec3(0.9, 0.9, 0.9) * pct5 + vec3(0.1, 0.1, 0.1) * pct5 * n * 2.;

	return vec4(color+color2+color3+color4+color5, 1.0);
}
