import React, { useEffect, useState } from 'react';
import { View, Text, ActivityIndicator, StyleSheet, useColorScheme } from 'react-native';
import Markdown from 'react-native-markdown-display';
import { supabase } from '../lib/supabase';
import { colors } from '../theme/colors';

export default function DocumentViewer({ documentType }: { documentType: string }) {
  const [content, setContent] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const colorScheme = useColorScheme();
  const theme = colorScheme === 'dark' ? colors.dark : colors.light;

  useEffect(() => {
    async function fetchDoc() {
      try {
        setLoading(true);
        const { data, error } = await supabase
          .from('legal_documents')
          .select('content')
          .eq('document_type', documentType)
          .eq('is_active', true)
          .single();

        if (error) throw error;
        if (data) setContent(data.content);
      } catch (e: any) {
        setError(e.message || 'Failed to load document.');
      } finally {
        setLoading(false);
      }
    }
    fetchDoc();
  }, [documentType]);

  if (loading) {
    return (
      <View style={[styles.center, { backgroundColor: theme.background }]}>
        <ActivityIndicator size="large" color={theme.primary} />
      </View>
    );
  }

  if (error || !content) {
    return (
      <View style={[styles.center, { backgroundColor: theme.background }]}>
        <Text style={{ color: theme.error || 'red' }}>{error || 'Document not found.'}</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Markdown
        style={{
          body: { color: theme.text, fontSize: 16, lineHeight: 26, fontFamily: 'System' },
          heading1: { color: theme.text, fontSize: 36, fontWeight: '700', marginBottom: 24, marginTop: 32 },
          heading2: { color: theme.text, fontSize: 24, fontWeight: '600', marginBottom: 16, marginTop: 24 },
          heading3: { color: theme.text, fontSize: 20, fontWeight: '600', marginBottom: 12, marginTop: 20 },
          paragraph: { marginBottom: 16, color: theme.textSecondary },
          link: { color: theme.primary, textDecorationLine: 'none' },
          list_item: { color: theme.textSecondary, marginBottom: 8 },
        }}
      >
        {content}
      </Markdown>
    </View>
  );
}

const styles = StyleSheet.create({
  center: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  container: {
    flex: 1,
    maxWidth: 800,
    width: '100%',
    alignSelf: 'center',
    paddingHorizontal: 24,
    paddingVertical: 40,
  }
});
