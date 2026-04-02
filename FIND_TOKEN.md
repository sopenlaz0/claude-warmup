# Alternative OAuth Token Extraction Methods

## Method 1: Browser Console (Quickest)

1. Open https://claude.ai/code
2. F12 → **Console** tab
3. Paste this and press Enter:

```javascript
// Try these one by one:
localStorage.getItem("oauthToken");
localStorage.getItem("anthropic.oauthToken");
localStorage.getItem("token");
localStorage.getItem("authToken");

// Or list all keys:
Object.keys(localStorage).filter(
  (k) => k.toLowerCase().includes("token") || k.toLowerCase().includes("auth"),
);
```

## Method 2: Network Tab (If localStorage is empty)

1. Open https://claude.ai/code
2. F12 → **Network** tab
3. Refresh the page (Ctrl+R / Cmd+R)
4. Look for requests to:
   - `claude.ai/api/auth/session`
   - `claude.ai/api/organizations`
   - Any request with "auth" in the name
5. Click the request → **Headers** tab
6. Look for **Authorization** header
7. The token will be: `Bearer sk-ant-oat01-...`
8. Copy just the part after `Bearer ` (starts with `sk-ant`)

## Method 3: Cookies

1. F12 → **Application** → **Cookies** → **https://claude.ai**
2. Look for:
   - `anthropic_session`
   - `oauth_token`
   - `auth_token`
   - Any cookie containing `sk-ant`

## Method 4: Session Storage

```javascript
// In console:
Object.keys(sessionStorage);
sessionStorage.getItem("oauthToken");
sessionStorage.getItem("token");
```

## Method 5: IndexedDB

1. F12 → **Application** → **IndexedDB**
2. Look for databases related to auth/session

## What the Token Looks Like

It should start with: `sk-ant-oat01-` followed by a long string of letters and numbers.

Example: `sk-ant-oat01-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

## If None of These Work

Try this curl command (needs your browser cookies):

```bash
# Get your session cookie from browser first
curl -s 'https://claude.ai/api/auth/session' \
  -H 'Cookie: session=YOUR_SESSION_COOKIE_HERE' \
  | head -c 500
```

Or use the browser's **Copy as cURL** feature on any API request and look for the token in the headers.

---

**Try Method 1 (Console) first - it's the fastest!**
