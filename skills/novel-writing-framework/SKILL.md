---
name: novel-writing-framework
description: A 12-step interactive AI writing framework for story creation covering ideation to rewriting. Use for: (1) Generating story concepts (2) Creating plot outlines (3) Designing characters and relationships (4) Structuring narratives with beat sheets (5) Planning scenes and set pieces (6) Writing dialogue with subtext (7) Developing themes and symbolism (8) Pacing and tension design (9) Crafting endings (10) Iterative rewriting. Ideal for novels, screenplays, web fiction, and collaborative story development.
---

# Novel Writing Framework

## Overview

This skill implements the 12-step "Save the Cat" interactive AI writing framework - a modular workflow for systematic story development from initial concept to final polish. The framework progresses linearly from creative ideation through detailed planning to revision, with Step 2 (the one-page synopsis) serving as the critical anchor point that must be updated before any major structural changes.

**Designed for:**
- Novelists and web fiction authors
- Screenwriters and TV writers
- Collaborative writing teams
- Rapid prototyping and multiple-ending exploration

**Output progression:**
```
High-concept ideas → One-page synopsis → Characters & Themes → Structure → Scenes → Set Pieces → Dialogue → Symbolism → Pacing → Ending → Rewrite
```

## Quick Start

To begin a new story project:

1. **Step 1: Ideation** - Provide genre preferences, themes, and keywords to generate 3-6 story concepts (200 words each)
2. **Select a concept** - Choose one concept to lock in as the project direction
3. **Step 2: Anchor** - Expand selected concept into a one-page synopsis (≤1000 words). **This becomes the project anchor.**
4. **Proceed sequentially** - Execute Steps 3-12 to develop the full story
5. **Maintain consistency** - Any major changes to the story must first be reflected in Step 2's anchor synopsis

## The 12-Step Workflow

| Step | Focus | Output |
|------|-------|--------|
| **1** | Ideation | 3-6×200-word story concepts |
| **2** | Synopsis | One-page anchor synopsis ≤1000 words |
| **3** | Characters | Character profiles + relationship map |
| **4** | Theme | Theme statement + narrative arc |
| **5** | Structure | Beat sheet (3-act / 15-beat / 8-sequence) |
| **6** | Scenes | Scene-by-scene outline with goals/conflicts |
| **7** | Set Pieces | Story events and key sequences design |
| **8** | Dialogue | Dialogue scripts with subtext notes |
| **9** | Symbolism | Motifs, symbols, and subplot layering |
| **10** | Pacing | Tension curves and transitions |
| **11** | Ending | Multiple ending options + final polish |
| **12** | Rewrite | Iterative improvement plan |

## Usage Workflow

### Phase 1: Foundation (Steps 1-2)

**Step 1: Ideation**
- Input: Genre preferences, themes, keywords, elements to avoid
- Output: 3-6×200-word high-concept story concepts
- Decision: Select one concept to proceed

**Step 2: One-Page Synopsis (ANCHOR POINT)**
- Input: Selected concept, intended ending type, mood keywords
- Output: Logline, character array, full synopsis (600-1000 words), themes, selling points, open questions
- **CRITICAL:** Treat this synopsis as immutable. Any structural changes must update this first.

### Phase 2: Design (Steps 3-5)

**Step 3: Characters & Relationships**
- Input: Core character count, character archetype themes
- Output: Character cards (≤180 words each), relationship network

**Step 4: Theme**
- Input: Theme keywords, symbolism density preference
- Output: Theme statement, counter-argument, argumentation path, scene anchors, motif list

**Step 5: Structure**
- Input: Structure template preference, twist frequency
- Output: Beat sheet, character state changes

### Phase 3: Detail (Steps 6-8)

**Step 6: Scene Outline**
- Input: Target scene count, parallel storylines
- Output: Scene list with goals, conflicts, turns, information gains

**Step 7: Set Pieces**
- Input: Total events, key scene count, type preferences
- Output: Event cards + 5-7 key set piece designs

**Step 8: Dialogue**
- Input: Scene selection, dialogue style preferences
- Output: Dialogue scripts with subtext, VO options, performance notes

### Phase 4: Refinement (Steps 9-11)

**Step 9: Symbolism & Layering**
- Input: Theme keywords, symbolism density, false memories allowed
- Output: Symbol list, subplot planning, information release schedule

**Step 10: Pacing & Tension**
- Input: Overall pacing expectations, twist frequency, multi-storyline setup
- Output: Pacing timeline, emotion waves, tension peaks, transition strategies

**Step 11: Endings**
- Input: Ending type preference, emotional aftertaste, sequel space
- Output: Power structure final state, character fates, world aftereffects, ending options A/B

### Phase 5: Iteration (Step 12)

**Step 12: Rewrite**
- Input: Feedback points, allowable change scope, priority issues
- Output: Problem checklist, rewrite strategy (outline/scene/dialogue levels), priorities, risk assessment

## Key Principles

### The Anchor Mechanism

**Step 2 is non-negotiable.** Once the one-page synopsis is approved:
- It serves as the single source of truth for story decisions
- Any changes to character, plot, or theme must update Step 2 first
- This prevents cascading inconsistencies and narrative drift

### Modular Design

Each step produces a specific, standalone deliverable that can be:
- Executed independently once prerequisites are met
- Stored as project documentation
- Compared across different versions or drafts
- Re-used in subsequent projects with adjustments

### Freedom Levels

The framework uses calibrated specificity:
- **High freedom** (creative): Steps 1, 3-4 (ideation, characters, themes)
- **Medium freedom** (parameters): Steps 2, 5-7 (structure, scenes, events)
- **Low freedom** (execution): Steps 8-12 (dialogue, pacing, polishing)

### Progressive Detail

Information density increases step-by-step:
- Step 1: 200-word concepts (quick comparisons)
- Step 2: 1000-word synopsis (core structure)
- Steps 3-5: Detailed design (characters/themes/beats)
- Steps 6-8: Granular planning (scenes/dialogue)
- Steps 9-12: Refinement (symbolism/pacing/rewrite)

## Adaptations

### For Web Fiction

- Adjust scene density (web fiction has far more "scenes" than films)
- Increase word counts for scene outlines (more narrative description)
- Emphasize pacing curves (reader-controlled consumption)
- Adapt transition strategies (no sound/visual constraints)

### For Novels

- Expand scene counts (30-55 scenes is film standard; novels may have 100+)
- Add chapter planning granularity
- Emphasize internal monologue and subtext
- Longer character arcs and relationship development

### For Screenplays

- Tighten scene formats (specific locations, day/night)
- Emphasize visual storytelling
- Compress dialogue (show, don't tell)
- Focus on act structure and set piece moments

## References

Detailed step templates and examples are available in the `references/` directory:

- **step1-ideation.md** - Story concept generation prompts
- **step2-synopsis.md** - One-page synopsis structure and validation
- **step3-characters.md** - Character profile templates
- **step4-theme.md** - Theme development and argumentation
- **step5-structure.md** - Beat sheet templates (3-act, 15-beat, 8-sequence)
- **step6-scenes.md** - Scene-by-scene planning framework
- **step7-setpieces.md** - Set piece design and event cards
- **step8-dialogue.md** - Dialogue writing with subtext
- **step9-symbolism.md** - Motif, symbol, and subplot planning
- **step10-pacing.md** - Pacing curves, tension mapping, transitions
- **step11-endings.md** - Ending design and option comparison
- **step12-rewrite.md** - Iterative improvement framework

Load these reference files when specific step-by-step guidance is needed for detailed execution.
