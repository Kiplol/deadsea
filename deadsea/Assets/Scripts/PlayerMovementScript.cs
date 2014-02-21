using UnityEngine;
using System.Collections;

public class PlayerMovementScript : MonoBehaviour {

	public float scale = 0.1f;

	Vector3 deltaVector;
	Vector3 currentVector;
	Vector3 lastVector;

	void Start () {
		deltaVector = new Vector3(0,0, transform.position.z);
		currentVector = new Vector3(0,0, transform.position.z);
		lastVector = new Vector3(0,0, transform.position.z);
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetMouseButtonDown(0))
		{
			lastVector.x = Input.mousePosition.x;
			lastVector.y = Input.mousePosition.y;
			currentVector.x = lastVector.x;
			currentVector.y = lastVector.y;
			deltaVector.x = 0;
			deltaVector.y = 0;
		}
		if (Input.GetMouseButton(0))
		{
			this.currentVector.x = Input.mousePosition.x;
			this.currentVector.y = Input.mousePosition.y;
			this.deltaVector = deltaForNewVector(currentVector);
			this.transform.position = new Vector3(transform.position.x + deltaVector.x, transform.position.y + deltaVector.y, transform.position.z);
			this.lastVector.x = this.currentVector.x;
			this.lastVector.y = this.currentVector.y;
		}
//		Debug.Log (Camera.main.WorldToScreenPoint(this.transform.position));

		Animator animator = GetComponent<Animator>();
		animator.SetFloat("vx", deltaVector.x);
	}

	Vector3 deltaForNewVector(Vector3 newVector)
	{
		return new Vector3((newVector.x - lastVector.x) * scale, (newVector.y - lastVector.y) * scale, transform.position.z);
	}
}
