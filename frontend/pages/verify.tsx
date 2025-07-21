import { useState } from "react";
import VerifyWidget from "../components/VerifyWidget";

export default function Verify() {
  const [url, setUrl] = useState("");
  return (
    <main className="p-4">
      <h2 className="text-xl font-bold mb-4">Verify Credential</h2>
      <input
        className="input w-full mb-4"
        placeholder="Paste credential URL…"
        value={url}
        onChange={(e) => setUrl(e.target.value)}
      />
      {url && <VerifyWidget url={url} />}
    </main>
  );
}