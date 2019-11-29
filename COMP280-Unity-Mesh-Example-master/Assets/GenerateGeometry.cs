using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//We need a mesh filter for this example
[RequireComponent(typeof(MeshFilter))]
public class GenerateGeometry : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        //Create a new Mesh
        Mesh mesh = new Mesh();
        mesh.name = "GeneratedMesh";

        //Grab the mesh filter and assign the newly created mesh
        GetComponent<MeshFilter>().mesh = mesh;

        //Create vertices, we must have these
        Vector3[] vertices =
        {
            new Vector3(0.0f,0.0f,0.0f),
            new Vector3(0.5f,1.0f,0.0f),
            new Vector3(1.0f,0.0f,0.0f)
        };

        //Normals and other elements are options but will be required
        //for lighting and texturing to work 
        Vector3[] normals =
        {
            new Vector3(0.0f,0.0f,-1.0f),
            new Vector3(0.0f,0.0f,-1.0f),
            new Vector3(0.0f,0.0f,-1.0f)
        };

        //Indices, called triangles in Unity, these are indices into the Vertex array above
        int[] triangles = { 0, 1, 2 };

        //Assign all the values in the mesh
        mesh.vertices = vertices;
        mesh.normals = normals;
        mesh.triangles = triangles;

    }
}
