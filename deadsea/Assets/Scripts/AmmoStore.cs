using UnityEngine;
using System.Collections;

public class AmmoStore : MonoBehaviour {

	public GameObject bulletPrefab;
	public ArrayList bullets = new ArrayList();

	void Awake () {
		Debug.Log("AmmoStore Awake");
	}

	void Start ()
	{

	}

	public Bullet getBullet()
	{
		if(bullets.Count > 0)
		{
			Bullet retBullet = bullets[0] as Bullet;
			bullets.Remove(retBullet);
			return retBullet;
		}
		return makeBullet();
	}

	private Bullet makeBullet()
	{
		GameObject bulletObject = Instantiate(bulletPrefab, transform.position, Quaternion.identity) as GameObject;
		Bullet bullet = bulletObject.GetComponent(typeof(Bullet)) as Bullet;
		bullet.setAmmoStore(this);
		return bullet;
	}	
}
