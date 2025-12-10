# MODULAR TOKEN MATERIAL IN UNITY

<picture>
<img src="https://github.com/lysardz/ModularUITokenUnity/blob/main/Exampletoken.gif" alt="Alt text">

</picture>

*See the Readme PDF file for images with explanation!*
*Here is the setup video:* https://youtu.be/1IjRzdLGKEM

This asset was made in Unity 6 ver 6000.1.2f for URP pipelines, but there is a package available for Unity 2021 too, tested in ver 2021.3.30f1
You can download the files “ModularTokenUnity6” or “ModularTokenUnity2021” in this repo. 
The project file itself was made in the Unity 6 ver outlined above.

This is a modular token material that I tried making so it is simple for artists to drag and drop their UI textures and blend them in one material. Allowing them to set up token templates and reuse them for different needs. 
You can use this to make tokens for characters or items, or for inventory slots - using whatever textures you make and being able to toggle layers.

Additionally, this asset uses some default art I created - you can also use these textures if you want. NO AI art was used, this is custom made. 
*This project is free for personal and commercial use*, however no redistribution, reselling, or claiming the work as your own. Please link back to this repository if sharing or showcasing the material.

# The material has the following function and customizability:
- Allows you to assemble sprites to create a character, or other, token consisting of an icon sprite(Main texture slot), background, border, glow and a possible extra border overlay. 
- Has a togglable glow behind the main texture, tweakable in softness, size, colour, noise, animation and other.
- You can use coloured sprites if you want, or you can export your textures in greyscale, and tint them in the material. This setup has gradient tinting.

You can also toggle which layers of the token are active, customizing it with your sprite needs. The toggleable layers include: 
- *Background* behind main texture/border
- *Glow* behind main texture
- *Border* in front of main texture
- An extra layer in front of the border for *overlay*s or other objects.

**Troubleshooting:**
- If any textures stretch unnaturally - please check that the sprite mode is set to single, and mesh type is set to full rect, in your texture import settings.
- If you come across any other issues, please let me know.

Project Setup:
In the project you will find a prefab folder with a UI image gameobject containing a token material example. You will also find a material folder, with examples and a default token material (this material has its colours set to white, replaced with your own textures).
To use the material, place it on any UI image. You can then replace the character sprite by adding your sprite to the source image of the component.


# The material is set up as follows:

### Textures:
- Main texture (assignable in the image component for items/characters/etc.) 
- Inner Background Tex (Toggleable to be invisible)
- Border Tex (Toggleable to be invisible)
- Overlay Tex ( Toggleable to be invisible)
The UI textures you use should preferably all be at the same pixel resolution. The default textures used here are all at 512x512, with the art positioned inside. I have a psd file (TokenTemplate.psd) that contains the sprites so you can have an example file.


### Tinting Textures:
Toggle Disable Tint to switch off tinting for coloured textures. Your original sprites won’t be affected. Export your sprites in greyscale and switch off Disable Tint to apply colours.
Border, background and overlay’s Highlights and Shadows can be separately coloured, blended together. 
You can adjust the gradient balances to change the ratio of the tinting -  
Border Gradient Balance/Overlay Gradient Balance/etc.

### Glow:
- Glow can be enabled or disabled.
- Default glow is a circle behind the main texture.
- Glow Colour applies a flat colour tint.
- Glow Size can be adjusted.
- Glow Edge Strength can be adjusted to a softer or harder edge.
- Glow Intensity adjusts the brightness ( also to help boost it when softening edges ).
- Noise can be toggled with Noise Enabled, applied to the glow circle.
- Noise Offset can be changed to have more control. 
- Glow Noise Threshold controls the noise influence from the center to the edges, controlling where the noise starts at the edges of the circle.
- Noise Animation Speed can be adjusted - at 0 the noise is static. The noise scrolls idly at the speed you set.
