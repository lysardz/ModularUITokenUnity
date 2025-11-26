#ifndef Token_Utilities_INCLUDED
#define Token_Utilities_INCLUDED

//code snippets of the unity gradient noise node from the documentation
float2 unity_gradientNoise_dir(float2 p)
{
    p = p % 289;
    float x = (34 * p.x + 1) * p.x % 289 + p.y;
    x = (34 * x + 1) * x % 289;
    x = frac(x / 41) * 2 - 1;
    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}
//code snippets of the unity gradient noise node from the documentation
float unity_gradientNoise(float2 p)
{
    float2 ip = floor(p);
    float2 fp = frac(p);
    float d00 = dot(unity_gradientNoise_dir(ip), fp);
    float d01 = dot(unity_gradientNoise_dir(ip + float2(0, 1)), fp - float2(0, 1));
    float d10 = dot(unity_gradientNoise_dir(ip + float2(1, 0)), fp - float2(1, 0));
    float d11 = dot(unity_gradientNoise_dir(ip + float2(1, 1)), fp - float2(1, 1));
    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
    return lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x);
}
//code snippets of the unity gradient noise node from the documentation
float Unity_GradientNoise_Out(float2 UV, float Scale)
{
    float noise = unity_gradientNoise(UV * Scale) + 0.5;
    return noise;
}

//Blend new layer on top of old one
float4 BlendRGB(float4 result, float4 newLayer)
{
    //blend colours through alpha change, new layer reference
    result.rgb = lerp(result.rgb, newLayer.rgb, newLayer.a);
    //blend towards new alpha
    result.a = lerp(result.a, 1, newLayer.a);
    return result;
}
float4 TintLayer(float alpha, float3 highlight, float3 shadow, float power, float4 layer, bool noTint)
{
    
   
    if (!noTint)
    {
        
        layer.rgb *= alpha;
        //lerp greyscale to colour, and also adjust with power
        layer.rgb *= pow(lerp(shadow, highlight, layer.r), power + 0.7);
        return layer;
    }
   
    
    return layer;
}
void MasterNode_float(float4 BG, float4 CHR, float4 BD, float4 OL, bool glow, bool addNoise, float glowSize, float glowEdge, float2 UV, float3 BGcolor, float3 BDhighlight, float3 BDshadow,
float3 OLhighlight, float3 OLshadow, float3 sdfColor, bool BDVis, bool BGVis, bool OLVis, float BDpower, float OLpower, float noiseScale, float glowEdgeFalloff,
float glowIntensity, float noiseOffset, float noiseTime, float animNoise, float3 BGhighlight, float3 BGshadow, float BGgradThresh, bool noTint, out float4 FinalTexture)
{
    float2 p = float2((UV - 0.5) * 2);
    
    //Add bg to blank
    float4 result = float4(0, 0, 0, 0);
    
    BG.a *= BGVis;
    //Add colour and blend layers
    BG.rgb = TintLayer(BG.a, BGhighlight, BGshadow, BGgradThresh, BG, noTint);
    result = BlendRGB(result, BG);
   
    
    //BG + Glow
    //First create noise, have influence from center outwards, based on sdf radius
    float noiseFalloff = smoothstep(0.7 * glowEdgeFalloff, 1, length(p) / glowSize);
    //Apply the influence to the noise, make visible, animation and offset settings
    float noise = smoothstep(0, 1, Unity_GradientNoise_Out(UV + noiseOffset + (noiseTime * animNoise), 30 * noiseScale) * noiseFalloff) * addNoise;
    //Change edges, add noise, tweak glow
    float4 sdf = smoothstep(0, -0.9 * glowEdge, length(p) - glowSize + noise) * (1 + glowIntensity);
    
    //Glow circle
    sdf.a = abs(sdf) * glow;
    //Glow tint
    sdf.rgb = sdf.a * sdfColor;
    //Add glow to background
    result = BlendRGB(result, sdf);
    
    //Character + BG + Glow
 
    result = BlendRGB(result, CHR);
    
   //Border to inner stuff
    BD.a *= BDVis;
    BD.rgb = TintLayer(BD.a, BDhighlight, BDshadow, BDpower, BD, noTint);
    result = BlendRGB(result, BD);
   
    //Overlay
    OL.a *= OLVis;
    OL.rgb = TintLayer(OL.a, OLhighlight, OLshadow, OLpower, OL, noTint);
    result = BlendRGB(result, OL);
   
    
    FinalTexture = result;
  
}




#endif //MYHLSLINCLUDE_INCLUDED