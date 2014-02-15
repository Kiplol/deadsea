using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour {

	public float speed = 5.0f;
	public AmmoStore ammoStore = null;
	public bool collided = false;
	private bool fired = false;
	public bool fromPlayer = false;
	
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
		Debug.Log(fromPlayer);
		if(fired)
		{
			if(other.tag == "Bullet")
			{
				//Nothing
			}
			else if(fromPlayer && other.tag == "Player")
			{
				//Nothing
			}
			else
			{
				ReturnToAmmoStore();
			}
		}
	}

	public void setAmmoStore (AmmoStore amSt)
	{
		ammoStore = amSt;
	}

	public void Fire()
	{
		fired = true;
		rigidbody2D.AddForce(Vector2.up * 5 * speed);
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
