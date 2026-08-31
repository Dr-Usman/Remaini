import os
import math
from PIL import Image, ImageDraw, ImageFont, ImageFilter

def create_feature_graphic():
    W, H = 1024, 500
    
    # 1. Base Gradient Canvas (Deep Cosmic Obsidian & Indigo)
    base = Image.new("RGBA", (W, H), (11, 14, 26, 255))
    draw_base = ImageDraw.Draw(base)
    
    top_col = (14, 16, 32)
    bot_col = (8, 9, 18)
    for y in range(H):
        factor = y / float(H)
        r = int(top_col[0] + (bot_col[0] - top_col[0]) * factor)
        g = int(top_col[1] + (bot_col[1] - top_col[1]) * factor)
        b = int(top_col[2] + (bot_col[2] - top_col[2]) * factor)
        for x in range(W):
            base.putpixel((x, y), (r, g, b, 255))
            
    # 2. Ambient Radial Glows (Right side behind devices & Top left near logo)
    glow_canvas = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    glow_draw = ImageDraw.Draw(glow_canvas)
    
    # Large Purple/Rose glow on the right
    glows = [
        (800, 250, 420, (139, 92, 246, 120)),   # Violet
        (720, 320, 300, (244, 63, 94, 90)),    # Rose/Coral
        (220, 140, 260, (99, 102, 241, 70)),   # Indigo brand glow
    ]
    
    for gx, gy, grad, gcol in glows:
        for r in range(grad, 0, -8):
            alpha = int(gcol[3] * (1.0 - (r / grad) ** 1.3))
            if alpha > 0:
                glow_draw.ellipse(
                    [gx - r, gy - r, gx + r, gy + r],
                    fill=(gcol[0], gcol[1], gcol[2], alpha)
                )
                
    base = Image.alpha_composite(base, glow_canvas)
    
    # 3. Create Phone Device Mockup Helper
    def create_mini_phone(screenshot_path, target_w=280, target_h=580):
        sc = Image.open(screenshot_path).convert("RGBA")
        sc_resized = sc.resize((target_w, target_h), Image.Resampling.LANCZOS)
        
        bezel = 8
        fw = target_w + bezel * 2
        fh = target_h + bezel * 2
        radius = 28
        
        phone = Image.new("RGBA", (fw, fh), (0, 0, 0, 0))
        pdraw = ImageDraw.Draw(phone)
        
        # Titanium frame
        pdraw.rounded_rectangle(
            [0, 0, fw, fh],
            radius=radius,
            fill=(18, 20, 28, 255),
            outline=(90, 100, 130, 255),
            width=2
        )
        
        # Screen Mask
        mask = Image.new("L", (target_w, target_h), 0)
        mdraw = ImageDraw.Draw(mask)
        mdraw.rounded_rectangle([0, 0, target_w, target_h], radius=radius - 6, fill=255)
        
        phone.paste(sc_resized, (bezel, bezel), mask)
        
        # Camera punch
        pdraw.ellipse([fw//2 - 4, bezel + 10, fw//2 + 4, bezel + 18], fill=(10, 10, 14, 255))
        
        # Shadow
        spad = 40
        sw = fw + spad * 2
        sh = fh + spad * 2
        shadow = Image.new("RGBA", (sw, sh), (0, 0, 0, 0))
        sdraw = ImageDraw.Draw(shadow)
        sdraw.rounded_rectangle(
            [spad, spad + 10, fw + spad, fh + spad + 10],
            radius=radius,
            fill=(0, 0, 0, 160)
        )
        shadow_blur = shadow.filter(ImageFilter.GaussianBlur(24))
        shadow_blur.paste(phone, (spad, spad), phone)
        
        return shadow_blur

    # 4. Render Devices on the right side
    # Back Device (Event detail with circular countdown ring or totals)
    back_phone = create_mini_phone("store_assets/screenshots/04_event_detail_totals_dark.png", target_w=240, target_h=500)
    # Front Device (Home Screen Light Mode)
    front_phone = create_mini_phone("store_assets/screenshots/01_home_screen_light.png", target_w=260, target_h=540)
    
    # Paste back phone (shifted up/right)
    base.paste(back_phone, (740, 30), back_phone)
    # Paste front phone (overlapping)
    base.paste(front_phone, (560, 50), front_phone)
    
    # 5. Left Side: Brand Logo, Typography & Feature Highlights
    draw = ImageDraw.Draw(base)
    
    # Load fonts
    try:
        font_title = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial Bold.ttf", 52)
        font_tagline = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial.ttf", 23)
        font_pill = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial Bold.ttf", 16)
        font_badge = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial Bold.ttf", 15)
    except:
        font_title = ImageFont.load_default()
        font_tagline = ImageFont.load_default()
        font_pill = ImageFont.load_default()
        font_badge = ImageFont.load_default()
        
    left_x = 55
    start_y = 65
    
    # App Icon: Using app_logo_1024.png with rounded squircle mask
    icon_size = 76
    try:
        raw_logo = Image.open("assets/icons/app_logo_1024.png").convert("RGBA")
        logo_res = raw_logo.resize((icon_size, icon_size), Image.Resampling.LANCZOS)
        
        # Rounded mask for the logo
        logo_mask = Image.new("L", (icon_size, icon_size), 0)
        lmdraw = ImageDraw.Draw(logo_mask)
        lmdraw.rounded_rectangle([0, 0, icon_size, icon_size], radius=20, fill=255)
        
        # Border outline
        logo_container = Image.new("RGBA", (icon_size, icon_size), (0, 0, 0, 0))
        logo_container.paste(logo_res, (0, 0), logo_mask)
        lcdraw = ImageDraw.Draw(logo_container)
        lcdraw.rounded_rectangle(
            [0, 0, icon_size, icon_size],
            radius=20,
            outline=(165, 180, 252, 220),
            width=2
        )
        base.paste(logo_container, (left_x, start_y), logo_container)
    except Exception as e:
        print(f"Error loading logo: {e}")
        
    # Top Category Tag
    tag_x = left_x + icon_size + 20
    tag_y = start_y + 12
    draw.text((tag_x, tag_y), "COUNTDOWN & EVENT TRACKER", font=font_badge, fill=(165, 180, 252, 255))
    
    # App Name
    name_y = tag_y + 24
    draw.text((tag_x, name_y), "Remaini", font=font_title, fill=(255, 255, 255, 255))
    
    # Tagline
    tagline_y = start_y + icon_size + 36
    draw.text((left_x, tagline_y), "Count every moment that matters.", font=font_tagline, fill=(243, 244, 246, 255))
    
    # Sub-description
    sub_y = tagline_y + 36
    draw.text(
        (left_x, sub_y),
        "Precision live countdowns with animated ticker,\nglowing progress rings & dynamic urgency alerts.",
        font=font_tagline,
        fill=(156, 163, 175, 240)
    )
    
    # Feature Pills / Badges
    pills_y = sub_y + 80
    pills = [
        ("Live 1s Ticker", (236, 72, 153)),
        ("Dynamic Urgency", (244, 63, 94)),
        ("100% Offline & Private", (16, 185, 129)),
    ]
    
    cur_px = left_x
    for ptext, pcol in pills:
        bbox_p = draw.textbbox((0, 0), ptext, font=font_pill)
        pw = (bbox_p[2] - bbox_p[0]) + 26
        ph = (bbox_p[3] - bbox_p[1]) + 14
        
        draw.rounded_rectangle(
            [cur_px, pills_y, cur_px + pw, pills_y + ph],
            radius=14,
            fill=(pcol[0], pcol[1], pcol[2], 35),
            outline=(pcol[0], pcol[1], pcol[2], 180),
            width=1
        )
        
        draw.text((cur_px + 13, pills_y + 7), ptext, font=font_pill, fill=(240, 245, 255, 255))
        cur_px += pw + 12
        
    # Convert RGBA to RGB (24-bit RGB PNG without alpha)
    final_rgb = Image.new("RGB", (W, H), (11, 14, 26))
    final_rgb.paste(base, (0, 0), base)
    
    out_path = "store_assets/feature_graphic.png"
    os.makedirs("store_assets", exist_ok=True)
    final_rgb.save(out_path, "PNG", optimize=True)
    print(f"Generated Feature Graphic: {out_path} ({W}x{H})")

if __name__ == "__main__":
    create_feature_graphic()
