using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PokeScript : MonoBehaviour
{
    public ShieldScript shieldScript;

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            var ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit))
            {
                shieldScript.WavePoke = hit.point;
            }
        }
    }
}
