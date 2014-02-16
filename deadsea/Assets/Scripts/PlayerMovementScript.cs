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
			currentVector.x = Input.mousePosition.x;
			currentVector.y = Input.mousePosition.y;
			deltaVector = deltaForNewVector(currentVector);
			transform.position = new Vector3(transform.position.x + deltaVector.x, transform.position.y + deltaVector.y, transform.position.z);
			lastVector.x = currentVector.x;
			lastVector.y = currentVector.y;
		}
//		int fingerCount = 0;
//		foreach (Touch touch in Input.touches) {
//			if (touch.phase != TouchPhase.Ended && touch.phase != TouchPhase.Canceled)
//				fingerCount++;
//			
//		}
//		if (fingerCount > 0)
//			print("User has " + fingerCount + " finger(s) touching the screen");
	}

	Vector3 deltaForNewVector(Vector3 newVector)
	{
		return new Vector3((newVector.x - lastVector.x) * scale, (newVector.y - lastVector.y) * scale, transform.position.z);
	}
}
