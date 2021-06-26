import Head from 'next/head'
import Image from 'next/image'
import Link from 'next/link'
import styles from '../styles/Home.module.css'
import { useRouter } from 'next/router'

export default function Home() {
  const router = useRouter()
  
  return (
    <div className={styles.container}>
      <Head>
        <title>SugarDAO</title>
        <meta name="description" content="Generated by create next app" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          Welcome to <a href="https://nextjs.org">SugarDAO</a>
        </h1>

        <p className={styles.description}>
          Become a daobetic, get exposure to $SUGAR today.
          <Link passHref href="/loans/open">
            <a className={styles.button}>Open a loan</a>
          </Link>
        </p>

        <div className={styles.grid}>
          <a href='#' onClick={() => router.push('/sugar-feed')} className={styles.card}>
            <h2>SugarFeed &rarr;</h2>
            <p>Check the real-time $SUGAR feed.</p>
          </a>

          <a href="https://nextjs.org/learn" className={styles.card}>
            <h2>Learn &rarr;</h2>
            <p>Read the whitepaper!</p>
          </a>

          <a
            href="https://github.com/vercel/next.js/tree/master/examples"
            className={styles.card}
          >
            <h2>Examples &rarr;</h2>
            <p>Discover and deploy boilerplate example Next.js projects.</p>
          </a>

          <a
            href="https://vercel.com/new?utm_source=create-next-app&utm_medium=default-template&utm_campaign=create-next-app"
            className={styles.card}
          >
            <h2>Deploy &rarr;</h2>
            <p>
              Instantly deploy your Next.js site to a public URL with Vercel.
            </p>
          </a>
        </div>
      </main>

      <footer className={styles.footer}>
        <a
          href="https://ethereum.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Powered by{' '}Ethereum
          <span className={styles.logo}>
            {/* <Image src="https://ethereum.org/static/8ea7775026f258b32e5027fe2408c49f/ed396/ethereum-logo-landscape-black.png" alt="Vercel Logo" layout='fill' height={32} /> */}
          </span>
        </a>
      </footer>
    </div>
  )
}
