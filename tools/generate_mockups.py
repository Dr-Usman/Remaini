import os
import math
from PIL import Image, ImageDraw, ImageFont, ImageFilter

def create_gradient(width, height, top_color, bottom_color, radial_glow=None):
    base = Image.new("RGBA", (width, height), top_color)
    top_r, top_g, top_b = top_color[:3]
    bot_r, bot_g, bot_b = bottom_color[:3]
    
    # Linear vertical gradient
    for y in range(height):
        factor = y / float(height)
        r = int(top_r + (bot_r - top_r) * factor)
        g = int(top_g + (bot_g - top_g) * factor)
        b = int(top_b + (bot_b - top_b) * factor)
        for x in range(width):
            base.putpixel((x, y), (r, g, b, 255))
            
    # Add ambient radial glow if specified
    if radial_glow:
        glow_x, glow_y, radius, glow_col = radial_glow
        glow_img = Image.new("RGBA", (width, height), (0, 0, 0, 0))
        draw_glow = ImageDraw.Draw(glow_img)
        
        for r in range(radius, 0, -8):
            alpha = int(glow_col[3] * (1.0 - (r / radius) ** 1.4))
            if alpha > 0:
                draw_glow.ellipse(
                    [glow_x - r, glow_y - r, glow_x + r, glow_y + r],
                    fill=(glow_col[0], glow_col[1], glow_col[2], alpha)
                )
        base = Image.alpha_composite(base, glow_img)
        
    return base

def draw_device_mockup(screenshot_path, target_w=850, target_h=1780):
    sc = Image.open(screenshot_path).convert("RGBA")
    sc_resized = sc.resize((target_w, target_h), Image.Resampling.LANCZOS)
    
    bezel = 16
    frame_w = target_w + bezel * 2
    frame_h = target_h + bezel * 2
    corner_radius = 58
    
    device = Image.new("RGBA", (frame_w, frame_h), (0, 0, 0, 0))
    device_draw = ImageDraw.Draw(device)
    
    # Titanium / Onyx frame
    device_draw.rounded_rectangle(
        [0, 0, frame_w, frame_h],
        radius=corner_radius,
        fill=(18, 20, 28, 255),
        outline=(85, 92, 115, 255),
        width=3
    )
    
    # Screen inner cutout mask
    screen_mask = Image.new("L", (target_w, target_h), 0)
    mask_draw = ImageDraw.Draw(screen_mask)
    mask_draw.rounded_rectangle(
        [0, 0, target_w, target_h],
        radius=corner_radius - 12,
        fill=255
    )
    
    device.paste(sc_resized, (bezel, bezel), screen_mask)
    
    # Punch-hole camera
    cam_x = frame_w // 2
    cam_y = bezel + 28
    cam_r = 10
    device_draw.ellipse(
        [cam_x - cam_r, cam_y - cam_r, cam_x + cam_r, cam_y + cam_r],
        fill=(12, 12, 16, 255),
        outline=(30, 32, 45, 255),
        width=2
    )
    
    # Drop shadow
    shadow_pad = 80
    full_w = frame_w + shadow_pad * 2
    full_h = frame_h + shadow_pad * 2
    shadow_img = Image.new("RGBA", (full_w, full_h), (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(shadow_img)
    
    shadow_draw.rounded_rectangle(
        [shadow_pad, shadow_pad + 20, frame_w + shadow_pad, frame_h + shadow_pad + 20],
        radius=corner_radius,
        fill=(0, 0, 0, 160)
    )
    shadow_blurred = shadow_img.filter(ImageFilter.GaussianBlur(38))
    
    shadow_blurred.paste(device, (shadow_pad, shadow_pad), device)
    return shadow_blurred

def render_mockup(
    output_path,
    screenshot_path,
    badge_text,
    badge_color,
    headline,
    subtitle,
    bg_top,
    bg_bot,
    glow_col
):
    W, H = 1080, 2400
    
    # Background
    bg = create_gradient(
        W, H,
        top_color=bg_top,
        bottom_color=bg_bot,
        radial_glow=(W // 2, 720, 600, glow_col)
    )
    
    draw = ImageDraw.Draw(bg)
    
    # Fonts
    try:
        font_badge = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial Bold.ttf", 24)
        font_head = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial Bold.ttf", 58)
        font_sub = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial.ttf", 32)
    except:
        font_badge = ImageFont.load_default()
        font_head = ImageFont.load_default()
        font_sub = ImageFont.load_default()
        
    # Badge with accent dot
    dot_radius = 5
    dot_gap = 14
    badge_pad_x = 24
    badge_pad_y = 10
    
    bbox_b = draw.textbbox((0, 0), badge_text, font=font_badge)
    text_w = bbox_b[2] - bbox_b[0]
    bw = text_w + badge_pad_x * 2 + dot_radius * 2 + dot_gap
    bh = bbox_b[3] - bbox_b[1] + badge_pad_y * 2
    bx = (W - bw) // 2
    by = 105
    
    draw.rounded_rectangle(
        [bx, by, bx + bw, by + bh],
        radius=22,
        fill=(badge_color[0], badge_color[1], badge_color[2], 50),
        outline=badge_color,
        width=2
    )
    
    # Accent dot
    dot_cx = bx + badge_pad_x + dot_radius
    dot_cy = by + bh // 2
    draw.ellipse(
        [dot_cx - dot_radius, dot_cy - dot_radius, dot_cx + dot_radius, dot_cy + dot_radius],
        fill=badge_color
    )
    
    # Badge text
    draw.text(
        (dot_cx + dot_radius + dot_gap, by + badge_pad_y - 2),
        badge_text,
        font=font_badge,
        fill=badge_color
    )
    
    # Headline
    hy = by + bh + 32
    bbox_h = draw.textbbox((0, 0), headline, font=font_head)
    hw = bbox_h[2] - bbox_h[0]
    draw.text(((W - hw) // 2, hy), headline, font=font_head, fill=(255, 255, 255, 255))
    
    # Subtitle
    sy = hy + (bbox_h[3] - bbox_h[1]) + 20
    bbox_s = draw.textbbox((0, 0), subtitle, font=font_sub)
    sw = bbox_s[2] - bbox_s[0]
    draw.text(((W - sw) // 2, sy), subtitle, font=font_sub, fill=(190, 200, 225, 240))
    
    # Phone Mockup
    device_img = draw_device_mockup(screenshot_path, target_w=840, target_h=1760)
    dev_w, dev_h = device_img.size
    dev_x = (W - dev_w) // 2
    dev_y = 510
    
    bg.paste(device_img, (dev_x, dev_y), device_img)
    
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    bg.save(output_path, "PNG", optimize=True)
    print(f"Generated: {output_path}")

if __name__ == "__main__":
    configs = [
        {
            "output": "store_assets/mockups/01_mockup_home_light.png",
            "screenshot": "store_assets/screenshots/01_home_screen_light.png",
            "badge_text": "SMART EVENT FEED",
            "badge_color": (99, 102, 241),
            "headline": "Count Every Moment",
            "subtitle": "Track birthdays, trips & milestones in one feed",
            "bg_top": (16, 20, 34),
            "bg_bot": (8, 10, 18),
            "glow_col": (99, 102, 241, 110)
        },
        {
            "output": "store_assets/mockups/02_mockup_home_dark.png",
            "screenshot": "store_assets/screenshots/02_home_screen_dark.png",
            "badge_text": "DYNAMIC URGENCY",
            "badge_color": (244, 63, 94),
            "headline": "Sleek Dark Mode Feed",
            "subtitle": "Spotlight cards & color-coded urgency badges",
            "bg_top": (22, 14, 30),
            "bg_bot": (9, 6, 16),
            "glow_col": (244, 63, 94, 100)
        },
        {
            "output": "store_assets/mockups/03_mockup_detail_units.png",
            "screenshot": "store_assets/screenshots/03_event_detail_units_light.png",
            "badge_text": "LIVE 1-SECOND TICKER",
            "badge_color": (236, 72, 153),
            "headline": "Live Precision Countdown",
            "subtitle": "Weeks, Days, Hours, Minutes & Seconds",
            "bg_top": (28, 16, 28),
            "bg_bot": (11, 8, 16),
            "glow_col": (236, 72, 153, 100)
        },
        {
            "output": "store_assets/mockups/04_mockup_detail_totals.png",
            "screenshot": "store_assets/screenshots/04_event_detail_totals_dark.png",
            "badge_text": "TOTALS BREAKDOWN",
            "badge_color": (16, 185, 129),
            "headline": "Cumulative Totals View",
            "subtitle": "Total Days, Hours, Minutes & live Seconds",
            "bg_top": (12, 26, 22),
            "bg_bot": (6, 13, 11),
            "glow_col": (16, 185, 129, 100)
        },
        {
            "output": "store_assets/mockups/05_mockup_add_event.png",
            "screenshot": "store_assets/screenshots/05_add_event_screen_light.png",
            "badge_text": "INSTANT SETUP",
            "badge_color": (168, 85, 247),
            "headline": "1-Tap Quick Presets",
            "subtitle": "Shortcuts, category icons & custom color swatches",
            "bg_top": (22, 18, 36),
            "bg_bot": (10, 8, 20),
            "glow_col": (168, 85, 247, 100)
        },
        {
            "output": "store_assets/mockups/06_mockup_settings.png",
            "screenshot": "store_assets/screenshots/06_settings_screen_dark.png",
            "badge_text": "100% PRIVATE & OFFLINE",
            "badge_color": (59, 130, 246),
            "headline": "Theme Modes & Preferences",
            "subtitle": "Tactile haptic feedback with zero data tracking",
            "bg_top": (14, 20, 36),
            "bg_bot": (7, 10, 20),
            "glow_col": (59, 130, 246, 100)
        }
    ]
    
    for cfg in configs:
        render_mockup(
            output_path=cfg["output"],
            screenshot_path=cfg["screenshot"],
            badge_text=cfg["badge_text"],
            badge_color=cfg["badge_color"],
            headline=cfg["headline"],
            subtitle=cfg["subtitle"],
            bg_top=cfg["bg_top"],
            bg_bot=cfg["bg_bot"],
            glow_col=cfg["glow_col"]
        )
