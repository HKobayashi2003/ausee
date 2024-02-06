import Image from "next/image";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="w-200 whitespace-nowrap">
        Welcome to Ausee!
      </div>
      <div className="fixed bottom-10 justify-center">
        <Image
          src="/next-assets/vercel.svg"
          alt="Vercel Logo"
          className="dark:invert"
          width={100}
          height={24}
          priority
        />
      </div>
    </main>
  );
}
