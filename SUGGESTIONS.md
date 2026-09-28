# Suggested improvements

Recommendations raised while building the site, **not applied** — they need real
information from the trust, or a decision only the trust can make. Listed roughly
by how much difference each would make.

---

## 1. Add UPI alongside the bank transfer

Right now the only way to give is a 15-digit account number and an IFSC code.
Someone moved by a rescue photo on their phone has to switch to a banking app and
retype all of it — most people abandon at that point.

A UPI ID turns that into a two-second action, and a QR code can be generated
directly from the ID, so no image needs to be designed or uploaded.

**Needed:** the trust's UPI ID (e.g. `petadoption@axis`).

---

## 2. Show 80G tax exemption status

If the trust is registered under 80G, donors can claim the donation against income
tax. This is a significant motivator for larger contributions, and many regular
donors specifically look for it before giving.

**Needed:** the 80G registration number, and whether receipts are issued.

If the trust is *not* 80G registered, say nothing — do not imply it.

---

## 3. Put credibility markers on the page

A first-time visitor is being asked to transfer money to an account belonging to
strangers. The cheapest reassurance available is proof the trust is real:

- Trust registration number
- Registered address (currently the page says only "Bengaluru, Karnataka," which
  reads as evasive to a cautious donor)
- Who runs the trust — a name, a photo, two sentences on why they started

The page currently contains no people at all. A named human with a face is the
single biggest trust signal a small charity's site can carry.

**Needed:** registration number, full address, founder name + photo + short bio.

---

## 4. Add real impact numbers

"We help animals" persuades far less than "over 200 rescues since 2021." Even
rough but honest figures anchor the page and give donors a sense of scale.

Good candidates: animals rescued, animals treated, animals rehomed, year founded.

**Needed:** real figures. These must not be invented — fabricated statistics on a
charity's donation page would be seriously damaging if ever questioned.

---

## 5. Replace the placeholder photos

Six placeholder images currently sit at `assets/rescue-1.svg` … `rescue-6.svg`.

To swap in real photos:

1. Add the photos to `assets/` (e.g. `rescue-1.jpg`)
2. In `index.html`, change the seven `src="assets/rescue-N.svg"` references to the
   new filenames — they are all marked with `<!-- PLACEHOLDER -->` comments
3. Delete the unused `.svg` files

Keep photos under ~400 KB each and roughly 1200×900 or larger. Filenames are
case-sensitive on GitHub's servers even though they are not on macOS.

**Note on consent:** if any photo shows a person (a volunteer, a vet, an adopter),
get their agreement before publishing it. Photos of animals mid-treatment are
fine, but consider whether the most graphic injury images belong on the landing
page or further down.

---

## 6. Get a custom domain

`sathvik09.github.io/petadoptionbangaloretrust` works, but a real domain such as
`petadoptionbangalore.org` looks materially more legitimate next to a request for
money, and costs roughly ₹900–1,500/year. HTTPS remains free and automatic.

---

## 7. Be aware the contact details will be scraped

The phone number, Gmail address and bank details are on a public, indexed page.
Expect spam calls and email. This is the normal trade-off for a public donation
page and the account number is not a secret — funds can only be credited to it,
not withdrawn — but it is worth knowing in advance rather than being surprised.

If the spam becomes a problem, a contact form (Formspree has a free tier that works
on static sites) can replace the exposed email address.

---

## Already done

These were fixed during the rebuild and need no further action:

- **Mobile menu now works.** The original hamburger button had no code behind it,
  and the nav links were hidden below 800px — mobile visitors had no navigation at all.
- **Tap-to-copy on the account number and IFSC**, so donors do not have to
  transcribe digits by hand. The original stylesheet had styling for this but no buttons.
- **Link previews.** Sharing the URL on WhatsApp, Facebook or Instagram now shows
  the logo, name and description instead of a bare link.
- **Favicon** wired up to the trust logo.
- **Accessibility**: keyboard focus outlines, a skip-to-content link, labelled
  menu button, and reduced-motion support.
- **Lazy-loaded gallery images**, so the page loads faster on mobile data.
- **Readable formatting.** The stylesheet was previously minified onto single
  lines; it is now commented and structured so a volunteer can edit it.
