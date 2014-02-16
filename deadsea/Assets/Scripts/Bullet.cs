using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour {
	
	public AmmoStore ammoStore = null;
	public bool collided = false;
	private bool fired = false;
	public int damage = 3;
	public CharacterScript shooter;
	
	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		if(collided)
		{

		}
		else if(fired)
		{
//			transform.position = new Vector3(transform.position.x, transform.position.y + speed, transform.position.z);
		}
	}

	void FixedUpdate ()
	{
		if(fired)
		{

		}
	}


	private void OnTriggerEnter2D(Collider2D other)
	{
		if(fired)
		{
			CharacterScript hitYou = other.GetComponent(typeof(CharacterScript)) as CharacterScript;
			if(hitYou == shooter)
			{
				//Do nothing
//				Debug.Log("Bullet hit its shooter.");
			}
			else if(other.tag == "Bullet")
			{
				//Do nothing
//				Debug.Log("Bullet hit another bullet.");
			}
			else
			{
				//Alright, let's actually do some damage
				collided = true;
				if(hitYou != null)
				{
					GameObject damageSource = null;
					if(shooter)
					{
						damageSource = shooter.gameObject;
						shooter.OnShotCollisionSuccess(other.gameObject);
					}
					hitYou.TakeDamage(damage, damageSource);
				}
				ReturnToAmmoStore();
			}
		}
	}

	void onBecomeInvisible()
	{
		ReturnToAmmoStore();
	}

	public void setAmmoStore (AmmoStore amSt)
	{
		ammoStore = amSt;
	}
	

	public void Fire(Vector2 dir)
	{
		fired = true;
		rigidbody2D.AddForce(dir);
	}

	public bool ReturnToAmmoStore()
	{
		collided = false;
		fired = false;
		rigidbody2D.velocity = Vector2.zero;
		if(ammoStore)
		{
			ammoStore.bullets.Add(this);
			transform.position = ammoStore.transform.position;
			return true;
		}
		else
		{
			return false;
		}
	}
}
