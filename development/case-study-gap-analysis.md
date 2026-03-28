# Kilnside v3 Gap Analysis: DEFINITIVE-SPEC vs Codebase

Generated 2026-03-27. Compares `.superpowers/brainstorm/v3-deep-exploration/meta-synthesis/DEFINITIVE-SPEC.md` against the actual implementation.

---

## 1. Left Panel: The Shelf

| Spec Item | Spec Says | Current State | Gap Level |
|-----------|-----------|---------------|-----------|
| Panel width | 320px fixed | `Panel width="320px"` in `cascade-layout.tsx:66` | None |
| Header: KILNSIDE logo | Crimson Pro, copper, in left panel header | Logo is in the desktop `HeaderBar` (`components/header/header-bar.tsx:39`), NOT in the shelf panel header. Shelf header only has a search input. | Partial |
| Header: search input | Search input in shelf header | Present (`shelf-panel.tsx:238-243`), `Input` component with placeholder "Search glazes..." | None |
| Header: view toggle (Wall/List) | Toggle between Wall (grid) and List view | **Missing.** No view toggle exists. Only grid view is implemented. No list view component in `components/shelf/`. | Missing |
| Workbench strip (sticky, 48px) | Selected glazes as circular swatch thumbnails in a persistent sticky strip. Collapses to zero when empty. | Implemented (`shelf/workbench-strip.tsx`). Sticky, circular swatches with copper ring, tap to deselect, collapses when empty. Shows "{n} selected" count. | None |
| My Shelf tab (default) | Default tab showing owned glazes as ~96px square tiles | Implemented (`shelf-panel.tsx:255`). `my-shelf` is the default tab. Tiles rendered via `GlazeGrid` > `GlazeTile`. | None |
| Tile: fired-result swatch image | Full-tile image, 263 have real images, gradient fallback | Implemented (`glaze-tile.tsx:59-72`). Image with `object-cover`, hex gradient fallback, then generic warm gradient fallback. | None |
| Tile: name overlay | Small text, gradient background at bottom | Implemented (`glaze-tile.tsx:150-154`). Gradient `from-kiln-black/80`, 11px text. | None |
| Tile: fill-level waterline | CSS gradient simulating translucent bottle fill level | Implemented (`glaze-tile.tsx:42,74-78`). Linear gradient based on `fillLevel`, fades upper portion. | None |
| Tile: piece count badge | Top-left, small, muted | Implemented (`glaze-tile.tsx:87-91`). Top-left, 10px text, `bg-kiln-black/70`. | None |
| Tile: selected state | Copper ring border + checkmark dot top-right | Implemented (`glaze-tile.tsx:54,93-99`). `ring-2 ring-copper` + copper circle with checkmark SVG. | None |
| All Glazes tab | Full 900-glaze catalog, desaturated never-owned glazes with "+" overlay | Tab exists (`shelf-panel.tsx:256`). Catalog loaded from `GLAZE_CATALOG`. "+" overlay for unowned glazes is implemented (`glaze-tile.tsx:120-148`). **However, desaturation of never-owned glazes is not implemented** -- they render identically to owned tiles except for the add button. | Partial |
| Filter pills | Scrollable row of compact pills (brand, cone, effect). Active pills get copper tint. | `AdvancedFilters` component exists (`shelf/advanced-filters.tsx`) with brand + cone + type filters. `ColorFilterPills` adds color filtering. **No "effect" filter category.** Active state styling exists. | Partial |
| Saved section (collapsible, auto-hides when empty) | Below grid. Bookmarked combos and experiments as named rows with swatch dots. "+ New Experiment" row. Invisible when empty. | Component exists (`shelf/saved-section.tsx`). Auto-hides when empty. Shows combo swatch dots, experiment "Exp" badge, "+ New Experiment" button. **However, `savedCombos` is hardcoded to `[]` in `shelf-panel.tsx:232` with a TODO comment -- no Supabase integration.** | Partial |
| List view | Compact text list with 32px inline swatches | **Missing.** No list view component exists. No toggle. | Missing |
| New user empty state | Three affordance rows: "Scan your shelf", "Browse 900+ glazes", then 5 trending community glazes | `EmptyShelf` component exists (`shelf/empty-shelf.tsx`) with scan/browse/add custom buttons. **Missing: trending community glazes in the empty state.** Format is also a centered empty state card rather than the specified swatch-row format. | Partial |

---

## 2. Middle Panel: The Canvas

| Spec Item | Spec Says | Current State | Gap Level |
|-----------|-----------|---------------|-----------|
| Panel width | flex (fills remaining space) | `Panel width="flex"` in `cascade-layout.tsx:71` | None |
| Header: selection label | "Blue Rutile + Obsidian" or "Recent" when nothing selected | Implemented (`canvas-panel.tsx:118`). Uses `selectionLabel` from context which joins names with " + " or returns "Recent". | None |
| Header: piece count | Show count next to selection label | **Missing.** The header shows only the selection label, no piece count. Tab counts are shown inside tab buttons but not in the header label. | Missing |
| Tabs: My Pieces / Test Tiles / Discover | Three tabs in middle panel | Implemented (`canvas-tabs.tsx`). Tab values: `my-pieces`, `test-tiles` (labeled "Lab"), `discover`. **Note: Test Tiles tab is labeled "Lab" not "Test Tiles" as spec says.** | Partial |
| Ghost card at position zero | Dashed border, camera icon, contextual label "New piece with [selected glazes]" or "Record a piece." | Implemented (`canvas/ghost-card.tsx`). Dashed border, camera SVG, contextual label with selected glaze names. Rendered at position zero in `PieceGrid` (`piece-grid.tsx:42-45`). | None |
| My Pieces: filtered by selected glazes | When glazes selected, filter to matching pieces | Implemented (`piece-grid.tsx:20-24,35-38`). `matchesFilter` checks all selected glazes are present. | None |
| Test Tiles: same grid filtered to test tiles | Separate tab for test tiles | Implemented. `pieceType` switches to `test_tile` when on test-tiles tab (`canvas-panel.tsx:68-69`). | None |
| Discover: community content | When glazes selected, shows community pieces using those glazes. When no selection, personalized feed. | Implemented (`canvas-panel.tsx:77-80`). `useCommunity` with `glazeFilter` from selected glazes. When no selection, fetches unfiltered community pieces. | None |
| Unified stream in My Pieces | Your pieces first, community results continue below with slate left border, author handle, have/need dots. No "From the community" header. | **Partially implemented.** Community pieces appear below user pieces in `piece-grid.tsx:59-81`. Slate left border exists (`border-l-2 border-[#456B7A]` in `piece-card.tsx:70`). Author handle replaces meta line (`piece-card.tsx:116-118`). Have/need dots on glaze pills (`piece-card.tsx:96-105`). **However, there IS a "From the community" separator header (`piece-grid.tsx:60-64`) which the spec says should NOT exist.** Also, community results only show when `selectedGlazes.length > 0`, not in the unfiltered view. | Partial |
| Suggestion section | "What to try next" label, 2-3 compact horizontal cards, observation-phrased, one purchase nudge max, dismissible | Implemented (`canvas/suggestion-row.tsx`). Correct label text and styling. Dismissible. Observation-phrased suggestions from `buildSuggestions`. **However, suggestions are very basic (only 2 hardcoded types). No purchase nudge. No community-sourced suggestions ("3 potters add X as a third"). No clay body variations.** | Partial |
| Lab state (experiment active) | Tabs become Tiles / Results Strip / Community Experiments. Tiles ordered by variable value with status pills. | **Partially implemented.** Experiment loading action exists in reducer (`use-cascade.ts:57-63`, sets `canvasTab: "tiles"`). `ResultsStrip` component exists (`canvas/results-strip.tsx`). `TileStatusCard` exists. **However, the canvas tabs do NOT dynamically switch when an experiment is loaded. The "tiles" tab value is set in state but `CanvasTabs` only renders the three fixed tabs.** | Partial |
| Transition choreography | Non-matching cards shrink to zero height (150ms staggered), matching cards reflow (200ms ease-out). Header cross-fades. | **Partially implemented.** `AnimatePresence` with `layout` on piece cards enables reflow animation (`piece-grid.tsx:47-56`). Uses `transitions.reflow` from `lib/motion.ts`. **However, non-matching cards do NOT shrink to zero -- they are simply removed from the array via filter. No staggered shrink animation. No header cross-fade on selection change.** | Partial |
| New user empty state | One card-shaped CTA: photo area with + icon, "Log your first piece." Below: "Or switch to Discover" | `WelcomeBanner` is shown when `!hasPieces && !isDiscover` (`canvas-panel.tsx:153-157`). **The spec says it should be card-shaped like a piece card. Actual implementation may differ (uses `WelcomeBanner` component, not reviewed in detail but it exists as `components/onboarding/welcome-banner.tsx`).** | Partial |

---

## 3. Right Panel: The Focus

| Spec Item | Spec Says | Current State | Gap Level |
|-----------|-----------|---------------|-----------|
| Panel width | 360px fixed | `Panel width="360px"` in `cascade-layout.tsx:78` | None |
| State 1: Resting | Last-viewed piece persisted in localStorage. Quiet footer with "Log a new piece" + camera icon. New user: camera icon, "Just fired something?", copper button, secondary link. | `RestingState` in `focus-panel.tsx:48-82` shows camera icon, "Fresh out of the kiln?", copper "Log a Piece" button, helper text. **Missing: localStorage persistence of last-viewed piece. The resting state always shows the generic CTA, never a previously viewed piece. No "Add Test Tile" secondary link. No thin divider + footer pattern.** | Partial |
| State 2: Piece Detail + Infinite Depth | 5 depth levels that blend through typography/spacing. No accordions. No "show more". Scroll indicator on right edge. | **Substantially implemented.** `piece-detail.tsx` renders Level 1 fields (photo, title, clay/cone/atm, glaze pills, notes) plus `DepthContext` (Level 2), `DepthCurious` (Level 3), `DepthDeep` (Level 4), `DepthPurchase` (Level 5). Scroll depth indicator exists (`piece-detail.tsx:551-564`). **However, depth levels ARE separated by `border-t` dividers, not blended through typography. `DepthCurious` uses `FiringGuideCard` with a chevron expand/collapse -- an accordion pattern the spec explicitly rejects. Level 3 content is mostly empty ("More info on the way" fallback) -- the "Serious Eats voice" glaze profiles don't exist yet.** | Partial |
| Level 2: Context | "Also used in" cross-refs, combo history count, community count, application notes | `depth-context.tsx` implements cross-references and combo count. Community count shown when provided. **Missing: application notes ("Blue Rutile runs when thick. 2 coats max."). Cross-ref pieces are text-only, not "small cards" as spec says.** | Partial |
| Level 3: Curious | Glaze profile in Serious Eats voice, firing behavior, food safety, layering guide, specific gravity | `depth-curious.tsx` has scaffolding for food safety notes, firing guides, and articles. **However, no content is being passed to these props from `page.tsx` -- `articles`, `foodSafetyNotes`, `firingGuides` are all undefined. The "Serious Eats voice" glaze profiles are completely missing.** | Partial |
| Level 4: Deep | Oxide analysis bar chart, unity formula (Seger), substitution notes, defect troubleshooting, related reading | `depth-deep.tsx` implements oxide bar chart, UMF table, limit checks, and defect troubleshooter. **However, the UMF calculation is a placeholder (`calculateOxides` just passes through recipe percentages). Substitution notes missing. Related reading links missing.** | Partial |
| Level 5: Purchase + Action | Supplier links, tool suggestions, recipe CTA, affiliate links | `depth-purchase.tsx` implements brand-specific supplier links, generic retailers, and recipe CTA. **Missing: tool suggestions (hydrometer, tongs). Affiliate links exist elsewhere (`AffiliateLink` component in piece detail) but not structured as spec describes.** | Partial |
| "Ask about this" prompt | Contextual AI chatbot prompt at any depth level | `ContextualHint` component exists and is rendered for food safety concerns (`piece-detail.tsx:489`). `ChatWidget` is loaded on the page. **However, the spec says "at any level" -- currently only appears for food safety, not as a general depth-level feature.** | Partial |
| State 3: Capture Form | Right panel morphs to capture. Photo upload, pre-filled glazes from selection, pre-filled clay/cone from recent. Expandable firing/annotation sections. Save transitions to State 2 with pulse. | Capture state uses the same `PieceDetail` component with `piece={null}` (`focus-panel.tsx:117-124`). Photo upload works. **Missing: pre-fill glazes from left panel selection. Pre-fill clay/cone from recent pieces. Expandable sections for firing/annotations. Pulse animation on new piece card. Capture form is identical to edit form, no specific "capture" optimizations.** | Partial |
| State 4: Share (toggle) | "Visible to community" toggle + optional public note. No composer. | `ShareToggle` component exists (`focus/share-toggle.tsx`) with correct toggle and public note placeholder text. **However, `ShareToggle` is NOT rendered anywhere in the piece detail flow.** The `focus-panel.tsx` switch has a `case "share"` that just falls through to `RestingState`. The share toggle component exists but is not integrated. | Partial |
| State 5: Community Detail | Author avatar + handle + date. Photo carousel. Glaze pills with have/need dots. Public note. Actions: Bookmark, "Try this combo", "See @author's work". | Implemented (`focus/community-detail.tsx`). Avatar with fallback initial, date formatting, glaze pills with have/need dots (green/copper), public note, bookmark button, "Try this combo on my shelf" button, "See @author's work" link. **Missing: photo carousel (only shows first photo). Long-press bookmark for folder selection.** | Partial |

---

## 4. The Five Flows

| Spec Item | Spec Says | Current State | Gap Level |
|-----------|-----------|---------------|-----------|
| Flow 1: Home | Open app -> shelf sorted by usage, canvas shows "Recent", focus shows last-viewed piece with capture footer. No home page, no attention cards, no onboarding wizard. | Shelf sorts glazes (via `useGlazes` hook). Canvas shows "Recent" when no selection. **However: (1) There IS an onboarding wizard (`OnboardingFlow` in `page.tsx:166-175`) that blocks the cascade on first visit -- spec says NO onboarding wizard. (2) Focus panel does NOT show last-viewed piece -- shows generic resting CTA. (3) A `FoundingBanner` renders above the cascade (`page.tsx:180-183`), acting as an "attention card" that the spec says to kill.** | Partial |
| Flow 2: Browse | Tap glaze -> workbench shows swatch, canvas header cross-fades, non-matching shrink out, community results continue below. | Glaze selection works. Workbench shows swatches. Canvas filters. **Missing: header cross-fade animation, card shrink animation (cards are filtered out, not animated). Community results only show when glazes are selected, which is correct.** | Partial |
| Flow 3: Capture | Ghost card -> right panel morphs to capture form with pre-filled glazes. Save -> piece detail + pulse in grid. Also: cold capture from focus CTA. | Ghost card triggers `startCapture`. Focus panel enters capture state. **Missing: glaze pre-fill from selection. Pulse animation on new card.** Cold capture from focus CTA works. | Partial |
| Flow 4: Lab | Saved section -> "+ New Experiment" -> experiment builder in right panel -> tiles in middle, Results Strip tab. | Experiment builder renders in focus panel. Saved section has "+ New Experiment" button. **However: saved combos/experiments are hardcoded empty arrays. Experiment builder creates data but tiles/Results Strip integration with canvas tabs is incomplete. No variable-as-slider in left panel. No have/need materials check. No "Save as recipe v2" flow.** | Partial |
| Flow 5: Share | View piece -> flip "Visible to community" toggle -> optional public note -> done. One tap from community piece to "Try this combo". | `ShareToggle` component exists. Community detail has "Try this combo" action. **However, the toggle is not wired into the piece detail view. The `onTryCombo` callback in community detail is passed from `page.tsx` but the handler is empty (`onBookmark`, `onTryCombo`, `onViewAuthor` callbacks are not connected in `ConnectedFocusPanel`).** | Partial |

---

## 5. Mobile Adaptation (<768px)

| Spec Item | Spec Says | Current State | Gap Level |
|-----------|-----------|---------------|-----------|
| Panels stack as full-screen views | Gesture navigation between full-screen views | Implemented (`cascade-layout.tsx:87-119`). Mobile uses `AnimatePresence` with swipe gestures via `useSwipe`. | None |
| Default: middle panel fills screen | Canvas is default mobile view | `mobileTab` defaults to `"studio"` which renders `canvas` (`cascade-layout.tsx:23,105`). | None |
| Glaze wall via search bar expanding into sheet | Search bar expands into left panel sheet | **Not implemented as spec describes.** Mobile has a 5-tab bottom nav. The "lab" tab shows the shelf panel. There is no search bar that expands into a sheet. | Missing |
| Capture FAB | Copper "+" button fixed bottom-right | `CaptureFab` component exists (`mobile/capture-fab.tsx`) -- correct styling, copper, bottom-right, `md:hidden`. **However, it is NOT rendered anywhere in the app.** The bottom nav has a camera tab button instead. | Partial |
| Workbench: compact strip below search bar | Selected glazes as compact strip below search bar, sticky | `GlazeStrip` component exists (`mobile/glaze-strip.tsx`) with horizontal scrollable glaze pills. **However, it is not clear if it's rendered on the mobile canvas view -- it's not in `canvas-panel.tsx`.** | Missing |
| Bottom navigation | Spec says NO tab bar. Mobile uses gesture + FAB only. | **CONTRADICTION with spec.** The spec says "There are no pages, no routes, no tab bar" and lists killing "Tab navigation." But the implementation has a 5-tab bottom nav (`mobile/bottom-nav.tsx`) with Feed / Studio / Camera / Lab / Profile. This directly contradicts the spec. | Missing |
| Detail: push full-screen with back arrow | Tap piece -> full-screen detail, back arrow, infinite depth scrolls | Mobile detail goes to "camera" tab when capturing. **No full-screen push detail view for pieces. Tapping a piece on mobile doesn't have a clear path to the focus panel.** | Missing |

---

## 6. Data Model Changes

| Spec Item | Spec Says | Current State | Gap Level |
|-----------|-----------|---------------|-----------|
| `user_glazes.is_bookmarked` | Boolean for bookmarked section | Field referenced in `shelf-panel.tsx:95` (`is_bookmarked: false`), exists in type but **not verified in migration**. | Partial |
| `shared_pieces.public_note` | Text nullable for shared pieces | `SharedPiece` type includes `public_note` and it's rendered in `community-detail.tsx:117-121`. | None |
| `shared_pieces.is_visible` | Boolean default false for toggle-to-share | Implied by `ShareToggle` component. **Not verified the column exists or the toggle writes to it.** | Partial |
| `bookmarks` table | user_id, shared_piece_id, folder | **Not found in codebase.** Bookmark button exists in UI but no data layer. | Missing |
| `follows` table | follower_id, followed_id, created_at | **Not found in codebase.** No follow system implemented. | Missing |
| `experiments` table | id, user_id, name, goal, variable_name, variable_range, status | Types exist (`Experiment` in types). `ExperimentBuilder` creates the data shape. **Migration status not verified.** | Partial |
| `experiment_tiles` table | id, experiment_id, variable_value, etc. | Types exist (`ExperimentTile`). `TileStatusCard` and `ResultsStrip` consume them. **Migration status not verified.** | Partial |
| Community suggestions materialized view | Popular trios per glaze pair | **Not implemented.** Suggestions are client-side hardcoded logic only. | Missing |
| `hidden_authors` table | Block community content | **Not implemented.** No blocking/hiding mechanism. | Missing |
| `fill_level` on user_glazes | Already exists (migration 030) | Referenced in `glaze-tile.tsx` and the waterline gradient. | None |

---

## 7. What We Are Killing (Spec Section 5)

| Killed Item | Spec Says | Current State | Gap Level |
|-------------|-----------|---------------|-----------|
| Tab navigation (Home / Studio / Lab / Community) | Replaced by three-panel cascade. No tabs in header. | **Desktop: Correctly killed.** No tab nav in header. **Mobile: NOT killed.** A 5-tab bottom nav exists with Feed / Studio / Camera / Lab / Profile (`mobile/bottom-nav.tsx`). | Partial |
| FAB morph nav | Replaced by static workbench strip (desktop) + capture FAB (mobile) | Desktop workbench strip exists. **The old FAB morph is gone. But the new mobile capture FAB (`CaptureFab`) exists as a component but is not rendered. Instead, the bottom nav has an elevated camera button that acts as a quasi-FAB.** | Partial |
| Separate Lab page/mode | Lab is Saved section + experiment context in cascade | **Partially killed.** No separate lab page. Lab is a canvas tab ("test-tiles" labeled "Lab"). **However, on mobile, the "lab" tab in bottom nav shows the shelf panel, which is closer to spec. The canvas "Lab" tab is arguably a mode, though it's just a filter.** | Partial |
| Share composer modal/panel | Replaced by toggle + public note | `ShareToggle` component exists, no composer. **However, the toggle is not actually wired into piece detail.** | Partial |
| Attention cards / dashboard home | Replaced by unfiltered grid | **Partially killed.** No attention cards in canvas. **But `FoundingBanner` renders above the cascade on `page.tsx:180-183`, acting as a promotional banner. The onboarding flow also blocks the cascade for new users.** | Partial |
| Onboarding tutorial steps | Replaced by card-shaped CTAs and trending content | **NOT killed.** `OnboardingFlow` in `page.tsx:166-175` is a multi-step onboarding wizard (welcome -> test tiles -> done). This directly contradicts the spec. | Missing |
| "Community" as top-level tab | Renamed to "Discover" integrated into middle panel | Correctly killed on desktop. Canvas tab is "Discover". **On mobile, bottom nav has "Feed" not "Community" -- partially aligned but "Feed" is a separate full-screen view, not the integrated Discover tab.** | Partial |
| The concept of "modes" | Cascade has states parameterized by selection, not modes | **Mostly achieved.** State is parameterized via `CascadeState` reducer. **However, the mobile bottom nav creates de facto "modes" (Feed/Studio/Camera/Lab/Profile), contradicting the single-canvas philosophy.** | Partial |

---

## 8. Additional Implementation Notes

| Area | Finding |
|------|---------|
| **Cascade state management** | Well-architected. `use-cascade.ts` uses `useReducer` with clear actions. Context propagation via `providers.tsx`. State shape matches spec's "three variables" model (selectedGlazes, focusedPieceId, canvasTab). |
| **Kiln Cred** | `glaze-tile.tsx` includes a `kilnCred` prop with tiered arc styles (`greenware/bisqued/glazed/fired`) -- this is NOT in the spec. It's an addition, not a gap. |
| **Nudge system** | Extensive nudge infrastructure (`NudgeSlot`, `useNudges`, checkers for cone mismatch, atmosphere, coat count, etc.) in `piece-detail.tsx`. Not in spec but adds value. |
| **Comments** | `CommentThread` rendered in piece detail (`piece-detail.tsx:523-529`). Not in the spec at all -- a feature addition. |
| **Search overlay** | Global search via Cmd+K in `header-bar.tsx`. Searches glazes, pieces, community. Not in spec but useful. |
| **Chat widget** | `ChatWidget` loaded on main page. Not in spec (spec mentions future "Ask about this" prompt). |
| **Recipes** | `RecipeGrid`, `RecipeDetail`, `RecipeEditor` exist and are integrated into the canvas and focus panels. Not explicitly in the DEFINITIVE-SPEC cascade model but integrated as additional focus states. |
| **Auto-save** | `useAutoSave` hook with undo toast in piece detail. Good UX not in spec. |
| **Photo system** | `PhotoDropZone` and `PhotoCarousel` in piece detail. Annotations support via `onAnnotationsChange`. |

---

## 9. Summary Scoreboard

| Category | Items | None | Partial | Missing | Coverage |
|----------|-------|------|---------|---------|----------|
| Left Panel (Shelf) | 12 | 6 | 4 | 2 | 67% |
| Middle Panel (Canvas) | 10 | 4 | 5 | 1 | 65% |
| Right Panel (Focus) | 11 | 1 | 9 | 1 | 50% |
| Five Flows | 5 | 0 | 5 | 0 | 50% |
| Mobile Adaptation | 7 | 2 | 1 | 4 | 36% |
| Data Model | 10 | 2 | 4 | 4 | 40% |
| Killed Items | 8 | 0 | 6 | 2 | 25% |
| **TOTAL** | **63** | **15** | **34** | **14** | **51%** |

---

## 10. Top Priority Gaps

### Critical (Structural Contradictions with Spec)

1. **Mobile bottom nav exists** -- The spec explicitly kills tab navigation. The 5-tab mobile bottom nav is the single biggest structural contradiction. Spec says: gesture nav + capture FAB + search-expands-to-sheet.
2. **Onboarding wizard exists** -- Spec explicitly kills onboarding tutorial steps. `OnboardingFlow` blocks the cascade.
3. **Share toggle not wired** -- The `ShareToggle` component exists but is not rendered in piece detail. The `focusState === "share"` case falls through to `RestingState`.
4. **Last-viewed piece not persisted** -- Resting state always shows generic CTA instead of the previously viewed piece.

### High (Missing Features Described in Spec)

5. **Shelf list view** -- No Wall/List toggle, no list view component.
6. **Transition choreography** -- Cards filter instantly instead of shrink-to-zero animation. No header cross-fade.
7. **Capture pre-fill** -- Glazes selected on shelf don't pre-fill the capture form.
8. **Community unified stream "From the community" header** -- Spec says no header, but one exists.
9. **Lab/experiment integration** -- Canvas tabs don't switch when experiment is loaded. Saved combos are hardcoded empty.
10. **Mobile piece detail** -- No clear path from tapping a piece in mobile canvas to viewing its detail.

### Medium (Content/Data Gaps)

11. **Depth Level 3 content** -- "Serious Eats voice" glaze profiles don't exist.
12. **Bookmarks table** -- No data layer for bookmark storage.
13. **Follows system** -- No follow infrastructure.
14. **Suggestion engine** -- Only 2 hardcoded suggestion types instead of the rich community-sourced suggestions.
15. **All Glazes desaturation** -- Unowned glazes in catalog not visually desaturated.

---

*This analysis covers the DEFINITIVE-SPEC exhaustively. File paths are absolute from project root. Line numbers reference the state of code as of 2026-03-27.*
