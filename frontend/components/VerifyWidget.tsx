export default function VerifyWidget({ url }: { url: string }) {
    const [valid, setValid] = useState<null | boolean>(null);
    async function handleVerify() {
      const res = await fetch("https://api.certichain.org/verify", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ url }),
      });
      const json = await res.json();
      setValid(json.valid);
    }
    return (
      <div>
        <button className="btn" onClick={handleVerify}>Verify</button>
        {valid !== null && (
          <p className="mt-2 font-semibold">
            {valid ? "✅ Credential valid" : "❌ Invalid or revoked"}
          </p>
        )}
      </div>
    );
  }