using UnityEngine;
using System;
using System.Collections;

public class PlayerShip : CharacterScript {
	
	public int bombs;
	public int charges;
	public float multiplier;
	public int progressToNextCharge;
	public int score = 0;

	private System.Random rnd;
	private int turretIdx;
	public int maxTurretIdx;
	protected int maxTurretsPossible = 8;

	void Awake ()
	{
		rnd = new System.Random();
		ammoStore = GetComponent(typeof(AmmoStore)) as AmmoStore;
	}

	// Use this for initialization
	void Start () {
		progressToNextCharge = 0;
		ResetPlayer();
	}
	
	// Update is called once per frame
	void Update () {
		framesSinceShot = (framesSinceShot + 1) % framesPerShot;
		if (Input.GetMouseButton(0))
		{
			if(framesSinceShot == 0)
			{
				Shoot();
			}
		}
	}

	private void ResetPlayer ()
	{
		health = 1;
		bombs = 3;
		charges = 3;
		multiplier = 1f;
		turretIdx = 0;
		setMaxTurrets(1);
		StartCoroutine(BecomeInvincibleForGivenSeconds(5));
	}

	IEnumerator BecomeInvincibleForGivenSeconds(int seconds) {
		invincible = true;
		yield return new WaitForSeconds(seconds);
		invincible = false;
	}
	
	public override Bullet Shoot ()
	{
		Bullet bullet = base.Shoot();
		bullet.gameObject.transform.position = posForTurretIndex(nextTurretIndex());
		return bullet;
	}

	private int nextTurretIndex()
	{
		int middleTurretIdx = maxTurretIdx / 2;
		if(turretIdx != middleTurretIdx)
		{
			turretIdx = middleTurretIdx;
		}
		else
		{
			turretIdx = rnd.Next(0, maxTurretIdx);
		}
//		turretIdx = (turretIdx + 1) % maxTurretIdx;
		return turretIdx;
	}

	private Vector3 posForTurretIndex(int turretIndex)
	{
		float spaceBetweenX = 0.2f * (1 + (1 / maxTurretIdx));
		float spaceY = 0.2f;
		float subtractionAmt = (spaceBetweenX * (maxTurretIdx - 1)) * 0.5f;
		float retX = (turretIdx * spaceBetweenX) - subtractionAmt;
		float retY = Math.Abs(retX) * spaceY;
		return new Vector3(transform.position.x + retX, transform.position.y - retY, transform.position.z);
	}

	private void setMaxTurrets(int nTurrets)
	{
		maxTurretIdx = Math.Min(nTurrets, maxTurretsPossible);
		framesPerShot = 10 / Math.Max((maxTurretIdx / 2), 1);
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
		setMaxTurrets(maxTurretIdx + 1);
	}
}
