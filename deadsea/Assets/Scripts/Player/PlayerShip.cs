using UnityEngine;
using System;

public class PlayerShip : DestructableScript {

	public int health;
	public int bombs;
	public int charges;
	public float multiplier;
	public int progressToNextCharge;
	public AmmoStore ammoStore;
	public bool flashing;

	private System.Random rnd;
	private int turretIdx;
	public int maxTurretIdx;

	void Awake ()
	{
		rnd = new System.Random();
	}

	// Use this for initialization
	void Start () {
		health = 100;
		bombs = 3;
		charges = 3;
		multiplier = 1f;
		progressToNextCharge = 0;
		flashing = false;
		turretIdx = 0;
		maxTurretIdx = 4;
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetMouseButtonDown(0))
		{
			Shoot(0);
		}
		if (Input.GetMouseButton(0))
		{
			Shoot(1);
		}
	}
	
	void Shoot (int ammoType)
	{
		switch (ammoType)
		{
		default:
		{
			Bullet bullet = ammoStore.getBullet();
			bullet.gameObject.transform.position = posForTurretIndex(nextTurretIndex());
			bullet.fromPlayer = true;
			bullet.Fire();
		}
			break;
		}
	}

	private int nextTurretIndex()
	{
		turretIdx = rnd.Next(0, maxTurretIdx);
		return turretIdx;
	}

	private Vector3 posForTurretIndex(int turretIndex)
	{
		float spaceX = 2.0f / (maxTurretIdx * 0.9f);
		float spaceY = 0.2f;
		float subtractionAmt = (spaceX * (maxTurretIdx - 1)) * 0.5f;
		float retX = (turretIdx * spaceX) - subtractionAmt;
		float retY = Math.Abs(retX) * spaceY;
		return new Vector3(transform.position.x + retX, transform.position.y - retY, transform.position.z);
	}
}
