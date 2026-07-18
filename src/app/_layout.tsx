import { Slot } from 'expo-router';
import { View, StyleSheet, useColorScheme, Text, ScrollView, Pressable, useWindowDimensions } from 'react-native';
import { colors } from '../theme/colors';
import { Link, usePathname } from 'expo-router';

export default function RootLayout() {
  const colorScheme = useColorScheme();
  const theme = colorScheme === 'dark' ? colors.dark : colors.light;
  const { width } = useWindowDimensions();
  const pathname = usePathname();

  const isMobile = width < 768;

  const links = [
    { name: 'Privacy Policy', path: '/' },
    { name: 'Terms of Service', path: '/terms' },
  ];

  return (
    <View style={[styles.container, { backgroundColor: theme.background }]}>
      {/* Top Header */}
      <View style={[styles.header, { borderBottomColor: theme.border }]}>
        <Link href="/" asChild>
          <Pressable>
            <Text style={[styles.logo, { color: theme.text }]}>Crimchart</Text>
          </Pressable>
        </Link>
        <Text style={[styles.headerTitle, { color: theme.textSecondary }]}>Privacy Center</Text>
      </View>

      <View style={[styles.contentWrapper, isMobile && styles.contentWrapperMobile]}>
        {/* Sidebar */}
        <View style={[styles.sidebar, isMobile && styles.sidebarMobile, { borderRightColor: theme.border }]}>
          {links.map((link) => {
            const isActive = pathname === link.path;
            return (
              <Link href={link.path as any} key={link.path} asChild>
                <Pressable style={StyleSheet.flatten([styles.navItem, isActive && { backgroundColor: theme.surface }])}>
                  <Text style={StyleSheet.flatten([styles.navText, { color: isActive ? theme.primary : theme.text }, isActive && styles.navTextActive])}>
                    {link.name}
                  </Text>
                </Pressable>
              </Link>
            );
          })}
        </View>

        {/* Main Content */}
        <ScrollView style={styles.mainContent} contentContainerStyle={styles.scrollContent}>
          <Slot />
        </ScrollView>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    height: 64,
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 24,
    borderBottomWidth: 1,
  },
  logo: {
    fontSize: 24,
    fontWeight: 'bold',
    marginRight: 12,
  },
  headerTitle: {
    fontSize: 18,
    fontWeight: '500',
  },
  contentWrapper: {
    flex: 1,
    flexDirection: 'row',
  },
  contentWrapperMobile: {
    flexDirection: 'column',
  },
  sidebar: {
    width: 280,
    borderRightWidth: 1,
    paddingVertical: 24,
    paddingHorizontal: 16,
  },
  sidebarMobile: {
    width: '100%',
    borderRightWidth: 0,
    borderBottomWidth: 1,
    flexDirection: 'row',
    paddingVertical: 12,
  },
  navItem: {
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderRadius: 8,
    marginBottom: 8,
  },
  navText: {
    fontSize: 16,
    fontWeight: '500',
  },
  navTextActive: {
    fontWeight: '700',
  },
  mainContent: {
    flex: 1,
  },
  scrollContent: {
    flexGrow: 1,
  }
});
