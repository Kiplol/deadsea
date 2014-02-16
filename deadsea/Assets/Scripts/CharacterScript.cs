using UnityEngine;
using System.Collections;

public class CharacterScript : MonoBehaviour {

	public int health;
	public AmmoStore ammoStore;
	public int pointsForDestroying;
	public SpriteAnimationScript animator;
	
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
		health = Mathf.Max(health - damage, 0);
		if(health == 0)
		{
			OnDeathBy(damageSourceObject);
		}
		return health;
	}

	public virtual void Shoot ()
	{
		Bullet bullet = ammoStore.getBullet();
		bullet.gameObject.transform.position = transform.position;
		bullet.fromPlayer = false;
		bullet.shooter = this;
		bullet.Fire();
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
		}
	}

	public virtual void OnShotCollisionSuccess(GameObject thingThatGotShot)
	{
	}

	public virtual void OnCharacterDestroySuccess(CharacterScript destroyedCharacter)
	{
	}
}
