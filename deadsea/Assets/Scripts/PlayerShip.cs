using UnityEngine;
using System;
using System.Collections;

public class PlayerShip : CharacterScript {
	
	public int bombs;
	public int charges;
	public float multiplier;
	public int progressToNextCharge;
	public bool invincible;
	public int score = 0;

	private System.Random rnd;
	private int turretIdx;
	public int maxTurretIdx;

	void Awake ()
	{
		rnd = new System.Random();
	}

	// Use this for initialization
	void Start () {
		progressToNextCharge = 0;
		ResetPlayer();
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetMouseButton(0))
		{
			Shoot();
		}
	}

	private void ResetPlayer ()
	{
		health = 1;
		bombs = 3;
		charges = 3;
		multiplier = 1f;
		turretIdx = 0;
		maxTurretIdx = 1;
		StartCoroutine(BecomeInvincibleForGivenSeconds(5));
	}

	IEnumerator BecomeInvincibleForGivenSeconds(int seconds) {
		invincible = true;
		yield return new WaitForSeconds(seconds);
		invincible = false;
	}
	
	public override void Shoot ()
	{
		Bullet bullet = ammoStore.getBullet();
		bullet.gameObject.transform.position = posForTurretIndex(nextTurretIndex());
		bullet.fromPlayer = true;
		bullet.shooter = this;
		bullet.Fire();
	}

	private int nextTurretIndex()
	{
		turretIdx = rnd.Next(0, maxTurretIdx);
		return turretIdx;
	}

	private Vector3 posForTurretIndex(int turretIndex)
	{
		float spaceX = 0.4f + ((1.0f / maxTurretIdx) * 0.5f);
		float spaceY = 0.2f;
		float subtractionAmt = (spaceX * (maxTurretIdx - 1)) * 0.5f;
		float retX = (turretIdx * spaceX) - subtractionAmt;
		float retY = Math.Abs(retX) * spaceY;
		return new Vector3(transform.position.x + retX, transform.position.y - retY, transform.position.z);
	}

	public override void OnShotCollisionSuccess(GameObject thingThatGotShot)
	{
		base.OnShotCollisionSuccess(thingThatGotShot);
		Debug.Log ("Nice!");
		multiplier += .05f;
	}

	public override void OnDeathBy(GameObject killer)
	{
		base.OnDeathBy(killer);
		ResetPlayer();
	}

	public override void OnCharacterDestroySuccess(CharacterScript destroyedCharacter)
	{
		base.OnCharacterDestroySuccess(destroyedCharacter);
		int scoreToAdd = (int)(destroyedCharacter.pointsForDestroying * multiplier);
		score += scoreToAdd;
	}
}
