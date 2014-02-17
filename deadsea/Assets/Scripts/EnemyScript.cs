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
		if(player)
		{
			Quaternion rotation = Quaternion.LookRotation(player.transform.position - transform.position, transform.TransformDirection(Vector3.forward));
			Quaternion lol = new Quaternion(0, 0, rotation.z, rotation.w);
			transform.rotation = Quaternion.RotateTowards(transform.rotation, lol, 1.0f * rotationFollowSpeed);
		}
	}
	
	public override void OnDeathBy (GameObject killer)
	{
		base.OnDeathBy (killer);
		Destroy(this.gameObject);
//		animator.sprites = SpriteAnimationScript.ExplosionSprites();
	}

	IEnumerator FlyIn()
	{
		float fYStart = 6.3f;
		float fYEnd = 1.4f;
		transform.position = new Vector3(transform.position.x, fYStart, 0.0f);
		int nFrames = 30;
		for(int i = 0; i< nFrames; i++)
		{
			float t = (i * 1.0f) / (nFrames * 1.0f);
			float currentY = fYStart + (Mathf.Pow(t, 0.1f) * (fYEnd - fYStart));
			transform.position = new Vector3(transform.position.x, currentY, 0.0f);
			yield return new WaitForSeconds(Time.deltaTime);
		}
		Shoot();
	}
}
