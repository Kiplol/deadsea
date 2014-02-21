using UnityEngine;
using System.Collections;

public class EnemySpawnScript : MonoBehaviour {

	public GameObject[] enemyTypes;
	public int framesPerEnemy;
	protected int framesSinceEnemy;
	public float vx = 0.1f;
	public AmmoStore ammoStore;
	public int maxEnemiesToSpawn;
	protected int enemiesSpawned = 0;

	// Update is called once per frame
	void Update () {
		UpdatePosition();
		framesSinceEnemy++;
		if(framesSinceEnemy >= framesPerEnemy)
		{
			framesSinceEnemy = 0;
			SpawnEnemy();
		}
	}

	void UpdatePosition()
	{
		int screenX = Screen.width;
		Vector2 posOnScreen = Camera.main.WorldToScreenPoint(transform.position);
		//		Debug.Log("posOnScreen = " + posOnScreen + ", screenX = " + screenX + ", screenY = " + screenY);
		if (posOnScreen.x < 0)
		{
			vx *= -1;
		}
		else if (posOnScreen.x > screenX)
		{
			vx *= -1;
		}
		transform.position = new Vector2(transform.position.x + vx, transform.position.y);
	}
	
	void Start ()
	{
	
	}
	
	public GameObject SpawnEnemy()
	{
		if(enemiesSpawned < maxEnemiesToSpawn || maxEnemiesToSpawn <= 0)
		{
			if(enemyTypes.Length > 0)
			{
				GameObject enemy = Instantiate(enemyTypes[Random.Range(0, enemyTypes.Length)], transform.position, Quaternion.identity) as GameObject;
				CharacterScript enemyCS = enemy.GetComponent(typeof(CharacterScript)) as CharacterScript;
				enemyCS.ammoStore = ammoStore;
				enemiesSpawned++;
				return enemy;
			}
			return null;
		}
		else
		{
			Destroy(this.gameObject);
			return null;
		}
	}
}
