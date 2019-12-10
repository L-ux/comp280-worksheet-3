using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShieldScript : MonoBehaviour
{
    public int repeatLimit;
    public int speed;

    public Material ShieldMaterial;

    private Vector4 wavePoke = Vector4.one;
    public Vector3 WavePoke { set { wavePoke = new Vector4(value.x, value.y, value.z, 0); } }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Debug.Log("SS Update");
        wavePoke.w  = Mathf.Min (wavePoke.w + (Time.deltaTime * speed) ,1);
        ShieldMaterial.SetVector("_WaveOrigin", wavePoke);
    }
}
