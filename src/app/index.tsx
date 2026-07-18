import { Redirect } from 'expo-router';

export default function IndexPage() {
  // Redirect to the privacy policy page by default
  return <Redirect href="/privacy" />;
}
