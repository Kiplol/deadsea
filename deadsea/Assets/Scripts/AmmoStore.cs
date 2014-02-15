using UnityEngine;
using System.Collections;

public class AmmoStore : MonoBehaviour {

	public GameObject bulletPrefab;
	public ArrayList bullets;

	void Start () {
		bullets = new ArrayList();
		for (int i = 0; i < 5; i++)
		{
			bullets.Add(makeBullet());
		}
	}
	
	// Update is called once per frame
	void Update () {
	
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
