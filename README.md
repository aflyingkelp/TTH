# TTH

A buildless personal hub for GitHub Pages. Includes YouTube embeds, local bookmarks and notes, a focus timer, a memory game, and one-to-one WebRTC chat with click-to-load GIF links.

## Deploy

Upload `index.html`, `style.css`, `app.js`, and `.nojekyll` to your repository. In Settings → Pages, deploy from `main` / root. No API keys, build step, or backend account are needed.

## Chat

Both people open the Chat tab. Host clicks Create invite and sends the generated code through a trusted channel. Friend pastes the invite and clicks Create reply. Host pastes that reply and clicks Connect reply. Both tabs must stay open. This is one-to-one only; no offline delivery, accounts, or persistent message history.

WebRTC encrypts transport but this app does not independently authenticate identities. Peer IP addresses may be visible. A Google STUN server assists discovery. Restrictive networks can prevent connectivity because there is no TURN relay. This is not a promise of anonymity or freedom from monitoring. Managed devices, participants, and network operators remain relevant to privacy. GIFs contact their external host only when a viewer chooses to load them. Use direct HTTPS image links; there is no search provider or file upload.

Notes, bookmarks, and theme are stored in localStorage on the current browser. Chat messages are held in memory, capped at 200 displayed messages. Clearing a conversation clears only the local view. Refreshing closes the chat and removes its local messages. External Google Fonts and YouTube players contact those services when loaded.

## Local preview

Serve this directory with any static HTTP server and open it in a modern browser. Clipboard access requires localhost or HTTPS. WebRTC requires compatible browsers and network connectivity.
