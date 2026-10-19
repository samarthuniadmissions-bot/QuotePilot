import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "QuotePilot — Every quote compared. Every decision smarter.",
  description: "AI-powered supplier quotation comparison for modern procurement teams.",
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="en"><body>{children}</body></html>;
}
