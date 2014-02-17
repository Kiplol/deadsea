using UnityEngine;
using System.Collections;

public class SpriteAnimationScript : MonoBehaviour {

	public Sprite[] sprites;
	private static Sprite[] explosionSprites;
	int index = 0;

	public int framesPerSecond;
	private SpriteRenderer spriteRenderer;
	// Use this for initialization
	void Start () {
		spriteRenderer = renderer as SpriteRenderer;
	}
	
	// Update is called once per frame
	void Update () {
		index = (int)(Time.timeSinceLevelLoad * framesPerSecond);
		index = index % sprites.Length;
		spriteRenderer.sprite = sprites[index];
	}

	public static Sprite[] ExplosionSprites()
	{
		if(explosionSprites == null)
		{
			Object[] objects = Resources.LoadAll("Explosion", typeof(Sprite));
			int nLen = objects.Length;
			explosionSprites = new Sprite[nLen];
			for(int i = 0; i < nLen; i++)
			{
				Sprite castSprite = objects[i] as Sprite;
				explosionSprites[i] = castSprite;
			}
		}
		return explosionSprites;
	}
}
