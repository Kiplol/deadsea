﻿using UnityEngine;
using System.Collections;

public class SpriteAnimationScript : MonoBehaviour {

	public Sprite[] sprites;
	private Sprite[] explosionSprites;

	public float framesPerSecond;
	private SpriteRenderer spriteRenderer;
	// Use this for initialization
	void Start () {
		spriteRenderer = renderer as SpriteRenderer;
	}
	
	// Update is called once per frame
	void Update () {
		int index = (int)(Time.timeSinceLevelLoad * framesPerSecond);
		index = index % sprites.Length;
		spriteRenderer.sprite = sprites[index];
	}

	public static Sprite[] ExplosionSprites()
	{
		return Resources.LoadAll("Sprites/explosion.hasgraphics.png") as Sprite[]; 
	}
}
