#!/usr/bin/env python3
"""
Content Evaluator - Generate HTML Report
Usage: python generate_report.py <content_file> [--output report.html]
"""

import sys
import json
import re
from datetime import datetime
from pathlib import Path

def read_content(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        return f.read()

def get_score_class(score):
    if score >= 70:
        return 'score-high', 'fill-high'
    elif score >= 50:
        return 'score-medium', 'fill-medium'
    else:
        return 'score-low', 'fill-low'

def generate_html_report(content, scores, output_path='report.html'):
    template_path = Path(__file__).parent.parent / 'assets' / 'report-template.html'
    
    with open(template_path, 'r', encoding='utf-8') as f:
        template = f.read()
    
    # Calculate total score
    total = (scores['hook'] * 0.25 + scores['velocity'] * 0.15 + 
             scores['novelty'] * 0.15 + scores['audience'] * 0.20 +
             scores['value'] * 0.15 + scores['share'] * 0.10)
    
    # Determine grade
    if total >= 85:
        grade = 'S级 - 极有可能爆款'
    elif total >= 70:
        grade = 'A级 - 有爆款潜力'
    elif total >= 55:
        grade = 'B级 - 中上水平'
    elif total >= 40:
        grade = 'C级 - 一般水平'
    else:
        grade = 'D级 - 较差'
    
    # Top 1% probability
    if total >= 85:
        top1_prob = '50-70'
        engagement_rate = '8-15'
    elif total >= 70:
        top1_prob = '30-50'
        engagement_rate = '5-8'
    elif total >= 55:
        top1_prob = '15-25'
        engagement_rate = '3-5'
    elif total >= 40:
        top1_prob = '5-10'
        engagement_rate = '1-3'
    else:
        top1_prob = '<5'
        engagement_rate = '<1'
    
    # Build replacements
    replacements = {
        '{{ARTICLE_TITLE}}': '内容评估',
        '{{EVALUATION_DATE}}': datetime.now().strftime('%Y-%m-%d %H:%M'),
        '{{TOTAL_SCORE}}': str(int(total)),
        '{{GRADE}}': grade,
        '{{HOOK_SCORE}}': str(scores['hook']),
        '{{VELOCITY_SCORE}}': str(scores['velocity']),
        '{{NOVELTY_SCORE}}': str(scores['novelty']),
        '{{AUDIENCE_SCORE}}': str(scores['audience']),
        '{{VALUE_SCORE}}': str(scores['value']),
        '{{SHARE_SCORE}}': str(scores['share']),
        '{{HOOK_COLOR}}': get_score_class(scores['hook'])[0],
        '{{VELOCITY_COLOR}}': get_score_class(scores['velocity'])[0],
        '{{NOVELTY_COLOR}}': get_score_class(scores['novelty'])[0],
        '{{AUDIENCE_COLOR}}': get_score_class(scores['audience'])[0],
        '{{VALUE_COLOR}}': get_score_class(scores['value'])[0],
        '{{SHARE_COLOR}}': get_score_class(scores['share'])[0],
        '{{HOOK_FILL_CLASS}}': get_score_class(scores['hook'])[1],
        '{{VELOCITY_FILL_CLASS}}': get_score_class(scores['velocity'])[1],
        '{{NOVELTY_FILL_CLASS}}': get_score_class(scores['novelty'])[1],
        '{{AUDIENCE_FILL_CLASS}}': get_score_class(scores['audience'])[1],
        '{{VALUE_FILL_CLASS}}': get_score_class(scores['value'])[1],
        '{{SHARE_FILL_CLASS}}': get_score_class(scores['share'])[1],
        '{{HOOK_COMMENT}}': scores.get('hook_comment', ''),
        '{{VELOCITY_COMMENT}}': scores.get('velocity_comment', ''),
        '{{NOVELTY_COMMENT}}': scores.get('novelty_comment', ''),
        '{{AUDIENCE_COMMENT}}': scores.get('audience_comment', ''),
        '{{VALUE_COMMENT}}': scores.get('value_comment', ''),
        '{{SHARE_COMMENT}}': scores.get('share_comment', ''),
        '{{TOP1_PROBABILITY}}': top1_prob,
        '{{ENGAGEMENT_RATE}}': engagement_rate,
        '{{READ_RATE}}': '65-75' if total >= 55 else '40-60',
        '{{OPTIMIZED_SCORE}}': str(int(total) + 15) if total < 85 else str(int(total)),
    }
    
    # Build suggestions HTML
    suggestions_html = ''
    for i, suggestion in enumerate(scores.get('suggestions', []), 1):
        suggestions_html += f'<li><span class="bullet suggestion">{i}</span><span>{suggestion}</span></li>\n'
    replacements['{{SUGGESTIONS}}'] = suggestions_html
    
    # Replace all placeholders
    for key, value in replacements.items():
        template = template.replace(key, value)
    
    # Write output
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(template)
    
    print(f'Report generated: {output_path}')
    print(f'Total Score: {int(total)}/100 ({grade})')

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: python generate_report.py <scores.json> [--output report.html]')
        sys.exit(1)
    
    scores_file = sys.argv[1]
    output = 'report.html'
    
    if '--output' in sys.argv:
        idx = sys.argv.index('--output')
        output = sys.argv[idx + 1]
    
    with open(scores_file, 'r', encoding='utf-8') as f:
        scores = json.load(f)
    
    generate_html_report(None, scores, output)
