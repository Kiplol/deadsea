using UnityEngine;
using System.Collections;

public class EnemyScript : CharacterScript {
	
	public int framesPerShot;
	protected int framesSinceShot = 0;
	// Use this for initialization
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

	public override void OnDeathBy (GameObject killer)
	{
		base.OnDeathBy (killer);
		Destroy(this.gameObject);
//		animator.sprites = SpriteAnimationScript.ExplosionSprites();
	}

	IEnumerator FlyIn()
	{
		float fYStart = 3.3f;
		float fYEnd = 1.4f;
		transform.position = new Vector3(transform.position.x, fYStart, 0.0f);
		int nFrames = 50;
		for(int i = 0; i< nFrames; i++)
		{
			Debug.Log(i);
			float t = (i * 1.0f) / (nFrames * 1.0f);
			float currentY = fYStart + (t * (fYEnd - fYStart));
			transform.position = new Vector3(transform.position.x, currentY, 0.0f);
			yield return new WaitForSeconds(Time.deltaTime);
		}
	}
}
