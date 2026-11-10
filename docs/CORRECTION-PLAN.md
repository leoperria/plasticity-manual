# Plasticity Manual Correction Plan

## Scope

- Revise `Plasticity_Manual_Extended_20261021-111155.pdf`.
- Use Plasticity 26.2.0 as the primary reference version.
- Preserve useful command coverage, diagrams, bookmarks and internal navigation.
- Distinguish confirmed corrections from claims requiring application testing.
- Verify behaviour against official documentation, version-specific release notes and, where available, the application.
- Do not invent missing behaviour, shortcuts, option meanings, tolerances or introduction dates.
- If application testing is unavailable, label unresolved claims explicitly and avoid presenting them as verified instructions.

## 1. Scope and Version Labels — Pages 1–3

- Remove automatic assignment of `25.1+` to features with unknown introduction dates.
- Use separate labels:
  - `Introduced in [version]` for confirmed introduction dates.
  - `Documented in [version]` for confirmed availability without a known introduction date.
  - `Verified in [build]` for application-tested behaviour.
- Audit every version tag throughout the document.
- Resolve the inconsistent dates for Thicken Face on page 69 and Alternative Duplicate on pages 36 and 56.
- Separate current command behaviour from historical changes.
- Replace unsupported completeness promises such as “every option explained” with an accurate description of coverage.

## 2. Core Concepts — Pages 3–5

- Introduce boundary representation (B-rep), geometry and topology.
- Explain that faces and edges can use analytic or spline geometry.
- Remove the implication that every object is stored exclusively as NURBS.
- Distinguish mathematical geometry, numerical precision, modelling tolerances and viewport tessellation.
- Correct the terminology: `order = degree + 1`.
- Replace “higher degree means smoother” with a qualified explanation of flexibility, continuity and knot structure.
- Remove the claim that more spans inherently make a curve less smooth.
- Explain that knot insertion and degree elevation can preserve the existing shape.
- Separate rational control-point weights from Rebuild’s fitting Weight parameter.
- Define a solid as a volume enclosed by a closed boundary; explicitly allow through-holes and enclosed cavities.
- Explain that G2 includes G1 and G0, and that G0 does not require a kink.
- Distinguish a surface from a trimmed face and a collection of faces from a valid solid.

## 3. Construction Planes, Snapping and Organisation — Pages 6–11

- Explain construction-plane origin and orientation separately.
- Distinguish drawing on the active plane from snapping onto off-plane geometry.
- Add an object-snapping versus grid-snapping comparison.
- Explain Ctrl behaviour separately for each snapping context.
- Distinguish numeric coordinates, distances, angles and scale factors.
- Explain changing display units versus scaling geometry.
- Add a procedure for checking imported dimensions.
- Reconcile material-cleanup descriptions on pages 10, 42 and 43; verify whether removing references is sufficient without deleting objects.
- Add an exercise covering creation, naming, saving and reuse of an inclined construction plane.

## 4. Navigation, Files and Selection — Pages 12–17

- Verify ordinary additive and subtractive selection in the target build.
- Document viewport, active-command and Outliner selection separately.
- State the exact modifiers for adding, removing and replacing selections.
- Add general instructions for confirming, cancelling, undoing and ending repeated-placement commands.
- Explain any context-dependent Esc behaviour.
- Add a backup-recovery procedure covering locating, opening, checking and saving a recovered file under a new name.
- Expand Delete versus Dissolve with verified face and edge examples.

## 5. Drawing Tools, Primitives and Dimensions — Pages 18–28

- Verify radius-versus-diameter input semantics for:
  - Circle variants.
  - Tangent Circle.
  - Spiral.
  - Sphere.
  - Cylinder.
- Test each relevant input with a known value, measure the result and record the exact field label and application build.
- Replace unresolved radius/diameter instructions with verified steps where possible.
- Split Measure Distance into separate procedures for:
  - One edge.
  - Two points.
  - Axis-projected distance.
  - Direct distance.
- Distinguish Dimension, measurement annotations and the Constraint System.
- Do not imply that entering a dimension automatically establishes a persistent parametric relationship.
- Add concise numerical examples for primitive creation.

## 6. Continuity and Curvature — Pages 29–30

- Qualify the constant-curvature/circular-arc explanation as applying to appropriate planar curves.
- Distinguish curvature combs from continuity-deviation combs.
- Distinguish visual comb scale from geometric acceptance tolerance.
- Resolve the conflicting descriptions of G0/G1/G2 Scale on pages 30 and 79.
- Do not claim that a visual scale control changes acceptance tolerances without verification.
- Add an example with measured G0 success and G1 failure.
- Show the corresponding numerical results, combs and surface shading.

## 7. Transforms, Copies, Arrays and Materials — Pages 31–43

- Remove the claim that planar projection universally preserves the original curve’s shape and continuity.
- Explain possible changes to lengths, angles and curvature, including degenerate projections.
- Verify and explain Radial Array’s Number 1, Number 2 and Step 1.
- State whether each array count includes the original object.
- Add numbered examples demonstrating count, pitch and total extent.
- Verify the interaction between Mirror’s Union halves and Make instances.
- Resolve Subdivide’s contradictory CV-count descriptions through testing.
- Avoid universal doubling or degree-change claims unless verified for the relevant input type.
- Add a comparison of Duplicate, Instance and Asset covering editability, dependencies and source updates.
- Reconcile material-removal behaviour with the earlier organisation chapter.

## 8. Curve Editing — Pages 44–61

- Explain Insert Knot as insertion at a curve parameter location, with control points adjusted to preserve shape.
- Remove the implication that the new CV necessarily lies at the clicked point.
- Describe joining in terms of accepted modelling tolerance rather than infinite mathematical exactness.
- Do not supply an undocumented numeric joining tolerance.
- Verify Offset Region’s Individual option and correct any reversed description.
- Add tested illustrations distinguishing Natural, Linear, Soft, Reflective and Arc extensions where available.
- Remove unpublished source notes from established instructions; retain them only as explicitly unverified observations.
- Add a missing-region checklist covering:
  - Open endpoints.
  - Non-coplanar geometry.
  - Duplicate or overlapping segments.
  - Self-intersections.
  - Region-display limits.

## 9. Solid Creation, Booleans and Fillets — Pages 62–75

- Preserve documented surface-edge support in Extrude unless application testing establishes a version-specific difference.
- Preserve the official Pipe dimensional-accuracy warning and attach its source.
- Expand Hollow versus Thicken with diagrams showing retained surfaces and thickness direction.
- Distinguish per-side thickness from total thickness.
- Add a Loft example covering closed-profile seams and twisting.
- Replace vague Sweep Parallel/Normal explanations with verified asymmetric-profile diagrams.
- Explain Boolean behaviour for overlapping, touching, tangent and disconnected inputs.
- Present moving a tool slightly as a diagnostic technique, not a universal repair.
- Add troubleshooting for small faces, tangency and near-coincident boundaries while preserving intended dimensions.
- Distinguish constant-radius circular fillets from other blend profiles.

## 10. Advanced Surfacing — Pages 76–86

- Replace simplistic “higher value means higher quality” statements with verified geometric effects and trade-offs.
- Explain how fitting Weight affects boundary adherence and surface appearance.
- Do not recommend reducing Weight without explaining potential accuracy loss.
- Present non-B-spline input as one possible Align failure cause, not the only cause.
- Add worked Square, XNurbs and Align examples showing:
  - Input boundaries.
  - Continuity and fitting settings.
  - Resulting control-point structure.
  - Measured boundary deviation.
  - Shading.
  - Joining outcome.
- Resolve Remove Nominal Surface’s contradictory descriptions using before/after geometry and CV inspection.
- Retain and prominently repeat the verified limitation that constraints are session-only in the covered version.
- Separate constraint persistence from persistence of the resulting geometry.

## 11. Face and Edge Operations — Pages 87–92

- Restrict Offset Face’s “body stays closed” explanation to successful solid edits.
- Explain sheet behaviour separately.
- State that Unwrap Face does not automatically produce a distortion-free manufacturing flat pattern.
- Explain that doubly curved surfaces generally cannot be flattened while preserving all lengths and angles.
- Verify Push Face’s Tab behaviour in the target build.
- Move older shortcut behaviour into compatibility notes.
- Add a Project versus Imprint versus Cut comparison showing separate curves, divided faces and separate bodies.

## 12. Import, Export and Sharing — Pages 93–100

- Correct `XY, YX, XZ` to `XY, YZ, XZ`.
- Distinguish SVG region-overlay suppression from missing curve geometry.
- Remove splitting an SVG into several files as a guaranteed workaround for a per-plane curve limit.
- Recommend only workarounds that actually reduce the relevant per-plane load.
- Resolve the conflicting Face Plane Tolerance recommendations on page 96.
- Explain Max Width and deviation tolerance as distinct controls.
- Add STL unit handling and explain its lack of a standard encoded length unit.
- Add a measured export/import round-trip example.
- Distinguish tessellation appearance from dimensional accuracy.
- Distinguish CAD surface U/V parameters from production-ready texture UV layouts.
- Add checks for exported selection, visibility and instances.
- Qualify Plasticity Share’s download restriction as viewer functionality.
- Do not imply that view-only publishing guarantees prevention of copying mesh data.
- Clearly distinguish published mesh data from original CAD/source geometry.

## 13. Shortcuts, Index and Sources — Pages 101–105

- Separate shortcut information into current default, historical default and interaction context.
- Preserve verified 26.1 changes:
  - All selection modes: Tab → 5.
  - Lock Distances: Tab → S.
- Replace ambiguous slash notation with explicit bindings.
- Write full modifier combinations for each command.
- Write sequential shortcuts as `O, then O`, not `OO`.
- Add exact page numbers and clickable destinations to every tool-index entry.
- Add clickable external links to specific supporting sources.
- Record source access dates and repository revisions where relevant.
- Label claims as:
  - Officially documented.
  - Application-tested.
  - General modelling advice.
  - Unresolved documentation conflict.

## 14. Practical Content and Layout

- Add a concise explanation of direct modelling, editability and persistence.
- Add one complete beginner project connecting sketching, solids, cuts, thickness, fillets and export.
- Add a geometry-failure troubleshooting workflow.
- Add a surface-quality tutorial connecting continuity, combs, tolerances and reflections.
- Add a verified version/licence/operating-system compatibility matrix.
- Increase body-text readability.
- Reduce repetitive confirmation instructions.
- Add application screenshots where interaction or option behaviour is ambiguous.
- Prevent detached card endings and orphaned “Related” sections, including the break on page 48.
- Preserve clear visual distinctions between instructions, historical notes and unresolved claims.

## 15. Final Validation and Deliverables

- Audit all corrected statements against their cited evidence.
- Check terminology, version labels, shortcuts and option names consistently across chapters.
- Reconcile duplicate descriptions and cross-references.
- Regenerate page numbers, contents, index, bookmarks and links.
- Render and inspect every final PDF page for clipping, overlap, unreadable text and broken card boundaries.
- Deliver the revised manual, editable source and a concise correction log.
- List unresolved items separately with the specific application test required.
- Do not describe the manual as fully verified while unresolved behavioural claims remain.
