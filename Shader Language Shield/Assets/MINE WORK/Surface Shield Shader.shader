Shader "Custom/Surface Shield Shader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _WaveOrigin("Wave Origin", Vector) = (0, 0, 0, 0)
        _WaveRadius("Wave Radius", float) = 2.0
        _WaveThickness("Wave Thickness", float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        fixed4 _WaveOrigin;
        float _WaveRadius;
        float _WaveThickness;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color

            float distance = length(IN.worldPos.xyz - _WaveOrigin.xyz) - _WaveRadius * _WaveOrigin.w;
            float halfThick = _WaveThickness / 2;
            float upper = distance + halfThick;
            float lower = distance - halfThick;

            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;// * 1-_WaveOrigin.w;
            clip(c.a - 0.5);
            float intensity = pow(1 - (abs(distance)/halfThick),2);

            o.Albedo = intensity * (lower < 0 && upper > 0) * c.rgb * (1 - _WaveOrigin.w);
            o.Emission = o.Albedo;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
