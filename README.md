# TTH

## YouTube browsing in Watch

Watch provides keyword search, topic shortcuts, region and duration filters, sorting, pagination, channel browsing from result cards, popular videos, embedded video and public playlist playback, watch later, and recently opened history. It uses YouTube's official Data API and privacy-enhanced embedded player. It does not embed the entire YouTube website, sign into YouTube accounts, or bypass network or video restrictions.

Keyword search and popular-video browsing require a user-supplied YouTube Data API v3 key. Open Watch → Search setup for the instructions and key field. Create/select a Google Cloud project, enable YouTube Data API v3, and create a key restricted to the YouTube Data API and the website referrer `https://aflyingkelp.github.io/*`. This covers this account's GitHub Pages origin. For local development, explicitly allow the chosen localhost address in the key restrictions as well. Consult [Google's setup guide](https://developers.google.com/youtube/data/getting-started) and [key restriction documentation](https://docs.cloud.google.com/api-keys/docs/add-restrictions-api-keys).

The key is sent directly from the browser to Google. By default it is kept in sessionStorage for the current tab; opting into Remember stores it in localStorage. Disconnect removes either copy. No key is committed to the repository or sent to the chat backend. Browser API keys are not server secrets and must be restricted. Each browser needs its own configured key; no shared site-wide search credential is installed. Google quotas apply. Requests are cached in memory for ten minutes and search is submitted explicitly rather than on each keystroke.

Pasted video and public playlist links work without a key, including shorts, live URLs, and timestamps. Public oEmbed metadata is requested for pasted videos when available. Saved items and the last 100 opened items stay in localStorage. Clearing history removes it from this browser. This history records opening a player, not completed viewing. Leaving Watch closes the player. Remote thumbnails, searches, metadata, and playback contact Google/YouTube.

Verification: URL parsing and invalid-host checks, playlist/timestamp construction, search filters and pagination, result normalization, and duration formatting pass automated checks. The interface was checked with a real official YouTube embed, Watch Later, History, and the missing-key setup state. Live Data API search still needs the user's restricted API key and was not verified with an active key.

## Global chat and kelps games uwu

The Global chat tab is a shared public room, separate from peer chat. It reads the latest 80 messages from the last 24 hours, refreshing every five seconds while open. Messages remain stored in Supabase beyond that display window and can be accessed by the backend administrator. This room is not end-to-end encrypted.

Sign in with a STAR//SQUARE username account or register through the existing STAR//SQUARE account API. The API creates Supabase-managed credentials without requesting a routable email address. Accounts are shared with STAR//SQUARE; there is no password recovery. Use a unique password. TTH holds access/refresh tokens in sessionStorage for the current tab, never the password. Signing out uses the account API. The publishable frontend key is public configuration, not an administrator credential.

The isolated `tth_global_messages` table enforces row-level security: public recent reads, authenticated posts owned by the current user with a matching username claim, and deletion by the author. A server trigger imposes three seconds between posts and 1,000 currently stored posts per account per day. Global GIFs use HTTPS links and load only when clicked. Mutes are local to each browser and can be reset. No automated moderation is included.

The **kelps games uwu** library embeds Star Square, No Return, Asian Simulator, and Summitbound, with full-screen and new-tab options. Summitbound is bundled at `games/summitbound.html` from the user's existing game. The other games remain hosted at their original GitHub Pages URLs. Game saves may be separate across site origins and embedded browser storage contexts.

A buildless personal hub for GitHub Pages. Includes YouTube embeds, local bookmarks and notes, a focus timer, a memory game, and one-to-one WebRTC chat with click-to-load GIF links.

## Deploy

Upload `index.html`, `style.css`, `app.js`, and `.nojekyll` to your repository. In Settings → Pages, deploy from `main` / root. No API keys, build step, or backend account are needed.

## Chat

Both people open the Chat tab. Host clicks Create invite and sends the generated code through a trusted channel. Friend pastes the invite and clicks Create reply. Host pastes that reply and clicks Connect reply. Both tabs must stay open. This is one-to-one only; no offline delivery, accounts, or persistent message history.

WebRTC encrypts transport but this app does not independently authenticate identities. Peer IP addresses may be visible. A Google STUN server assists discovery. Restrictive networks can prevent connectivity because there is no TURN relay. This is not a promise of anonymity or freedom from monitoring. Managed devices, participants, and network operators remain relevant to privacy. GIFs contact their external host only when a viewer chooses to load them. Use direct HTTPS image links; there is no search provider or file upload.

Notes, bookmarks, and theme are stored in localStorage on the current browser. Chat messages are held in memory, capped at 200 displayed messages. Clearing a conversation clears only the local view. Refreshing closes the chat and removes its local messages. External Google Fonts and YouTube players contact those services when loaded.

## Local preview

Serve this directory with any static HTTP server and open it in a modern browser. Clipboard access requires localhost or HTTPS. WebRTC requires compatible browsers and network connectivity.
