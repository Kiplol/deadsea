﻿using UnityEngine;
using System.Collections;

public class CharacterScript : MonoBehaviour {

	public int health;
	public AmmoStore ammoStore;
	public int pointsForDestroying;
	public SpriteAnimationScript animator;
	public int framesPerShot;
	protected int framesSinceShot = 0;
	public float shootSpeed = 1.0f;
	public bool invincible;
	
	// Use this for initialization
	void Start () {

	}

	void Awake ()
	{
		animator = this.GetComponent(typeof(SpriteAnimationScript)) as SpriteAnimationScript;
	}
	
	// Update is called once per frame
	void Update () {

	}

	public int Health()
	{
		return health;
	}

	public int TakeDamage(int damage, GameObject damageSourceObject)
	{
		if(!invincible)
		{
			health = Mathf.Max(health - damage, 0);
			if(health == 0)
			{
				OnDeathBy(damageSourceObject);
			}
		}
		return health;
	}

	public virtual Bullet Shoot ()
	{
		Vector2 dir = transform.rotation * Vector2.up * -1 * shootSpeed;
		if(this.tag == "Player")
		{
			dir *= -1;
		}
		return Shoot(dir);
	}

	public virtual Bullet Shoot (Vector2 dir)
	{
		if(ammoStore)
		{
			Bullet bullet = ammoStore.getBullet();
			bullet.gameObject.transform.position = transform.position;
			bullet.shooter = this;
			bullet.Fire(dir);
			return bullet;
		}
		return null;
	}
	
	IEnumerator ExplodeAndDie()
	{
		animator.sprites = SpriteAnimationScript.ExplosionSprites();
		int nLen = animator.sprites.Length;
		for(int i = 0; i < nLen; i++)
		{
			yield return i;
		}
		Destroy(this.gameObject);
	}

	public virtual void OnDeathBy(GameObject killer)
	{
		if(killer)
		{
			CharacterScript killerChar = killer.GetComponent(typeof(PlayerShip)) as CharacterScript;
			if(killerChar)
			{
				killerChar.OnCharacterDestroySuccess(this);
			}
			StartCoroutine(ExplodeAndDie());
		}

	}

	public virtual void OnShotCollisionSuccess(GameObject thingThatGotShot)
	{
	}

	public virtual void OnCharacterDestroySuccess(CharacterScript destroyedCharacter)
	{
	}
}
