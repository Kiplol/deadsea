using UnityEngine;
using System.Collections;

public class EnemyScript : CharacterScript {

	public float rotationFollowSpeed;

	void Start () {
		StartCoroutine(FlyIn());

	}
	
	// Update is called once per frame
	void Update () {
		framesSinceShot = (framesSinceShot + 1) % framesPerShot;
		if(framesSinceShot == 0)
		{
			Shoot();
		}
	}

	void FixedUpdate ()
	{
		GameObject player = GameObject.FindGameObjectWithTag("Player");
		if(player && rotationFollowSpeed > 0)
		{
			Quaternion rotation = Quaternion.LookRotation(player.transform.position - transform.position, transform.TransformDirection(Vector3.forward));
			Quaternion lol = new Quaternion(0, 0, rotation.z, rotation.w);
			transform.rotation = Quaternion.RotateTowards(transform.rotation, lol, 1.0f * rotationFollowSpeed);
		}
	}
	
	public override void OnDeathBy (GameObject killer)
	{
		base.OnDeathBy (killer);
//		Destroy(this.gameObject);
//		animator.sprites = SpriteAnimationScript.ExplosionSprites();
	}

	IEnumerator FlyIn()
	{
		//Set starting point
		Vector3 startPos = Camera.main.ScreenToWorldPoint(new Vector3(0, Screen.height, 0));
		startPos = new Vector3(transform.position.x, startPos.y, transform.position.z);
		float fYStart = startPos.y;
		transform.position = startPos;

		//Set end point
		float fYEnd = 1.4f;
		transform.position = startPos;
		int nFrames = 40;
		for(int i = 0; i< nFrames; i++)
		{
			float t = (i * 1.0f) / (nFrames * 1.0f);
			float currentY = fYStart + (Mathf.Sqrt(t) * (fYEnd - fYStart));
			transform.position = new Vector3(transform.position.x, currentY, 0.0f);
			yield return new WaitForSeconds(Time.deltaTime);
		}
		Shoot();
	}
}
